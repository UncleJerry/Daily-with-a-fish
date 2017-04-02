//
//  SignupController.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/3/30.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit

class SignupController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var FirstNLabel: UITextField!
    @IBOutlet weak var LastNLabel: UITextField!
    @IBOutlet weak var Tips: UILabel!
    @IBOutlet weak var MaleButton: RadioBox!
    @IBOutlet weak var FemaleButton: RadioBox!
    

    @IBAction func MaleTouch(_ sender: RadioBox) {
        MaleButton.doesSelected = true
        FemaleButton.doesSelected = false
    }
    @IBAction func FemaleTouch(_ sender: RadioBox) {
        FemaleButton.doesSelected = true
        MaleButton.doesSelected = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
