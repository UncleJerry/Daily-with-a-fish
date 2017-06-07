//
//  NewReminderController.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/5/31.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit

class NewReminderController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let str = detail {
            DetailField.text = str
        }
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        //NextButton.isEnabled = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var DetailField: UITextField!
    @IBOutlet weak var ModelPicker: UIPickerView!
    
    let pickerData = ["None", "Daily", "Weekly", "Monthly", "Yearly"]
    var selectedModel = 0
    var detail: String? 
    
    @IBAction func ValueChanged(_ sender: UITextField) {
        if !(DetailField.text?.isEmpty)! {
            NextButton.isEnabled = true
        }else{
            NextButton.isEnabled = false
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: pickerData[row], attributes: [NSForegroundColorAttributeName : UIColor.white])
        return attributedString
    }
    
    @IBAction func GotoNext(_ sender: UIButton) {
        
        if selectedModel == 1 {
            self.performSegue(withIdentifier: "DayMode", sender: nil)
        }else if selectedModel == 2 {
            self.performSegue(withIdentifier: "WeekMode", sender: nil)
        }else if selectedModel >= 3 || selectedModel == 0{
            self.performSegue(withIdentifier: "MonthAndYearModel", sender: nil)
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MonthAndYearModel" {
            let destination: MonthYearViewController = segue.destination as! MonthYearViewController
            
            destination.model = selectedModel
            destination.detail = DetailField.text
        }
        
        if segue.identifier == "WeekMode"{
            let destination: WeekViewController = segue.destination as! WeekViewController
            
            destination.detail = DetailField.text
        }
        
        if segue.identifier == "DayMode"{
            let destination: DayViewController = segue.destination as! DayViewController
            
            destination.detail = DetailField.text
        }
    }
    

}
