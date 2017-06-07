//
//  WeekViewController.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/6/6.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import SwiftyJSON

class WeekViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        TimePicker.setValue(UIColor.white, forKey: "textColor")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    var detail: String?
    
    @IBOutlet weak var WeekPicker: UIPickerView!
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var TimePicker: UIDatePicker!
    
    let pickerData = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var selectedWeek = 0
    var connected = NetworkReachabilityManager(host: "https://jerrypho.club:3223/")?.isReachable
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: pickerData[row], attributes: [NSForegroundColorAttributeName : UIColor.white])
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedWeek = row
    }
    
    @IBAction func SaveNotification(_ sender: UIButton) {
        
        connected = NetworkReachabilityManager(host: "https://jerrypho.club:3223/")?.isReachable
        
        if !connected! {
            NoConnection(message: "Seems like you have no connection, please try again later.")
            
            return
        }
        
        let dateArray = TimePicker.date.toIntArray
        let newNotify = Notification()
        let uuid = getUUID()
        
        newNotify.localID = uuid
        newNotify.detail = detail
        newNotify.minute = dateArray[4]
        newNotify.hour = dateArray[3]
        newNotify.setModel(model: .Week)
        newNotify.weekName = pickerData[selectedWeek]
        
        try! realm.write {
            realm.add(newNotify)
        }
        let parameter: Parameters = ["hour": dateArray[3], "minute": dateArray[4], "repeat": 2, "detail": detail ?? "No content", "week": pickerData[selectedWeek]]
        
        Alamofire.request("https://jerrypho.club:3223/Add_Notification",method: .post, parameters: parameter).validate(statusCode: 200...202).responseJSON { response in
            switch response.result {
            case .success:
                let json = JSON(response.value!)
                let notifyid = json["notifyid"].intValue
                
                let notification = realm.objects(Notification.self).filter("localID = %@", uuid)
                try! realm.write {
                    notification[0].notifyID = notifyid
                }
                
                
                
            case .failure(let error):
                print(error)
            }
        }
        
        self.performSegue(withIdentifier: "SuccessFromWeek", sender: nil)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ReturnDetailPage" {
            let destination: NewReminderController = segue.destination as! NewReminderController
            
            destination.detail = detail
        }
    }
    
}
