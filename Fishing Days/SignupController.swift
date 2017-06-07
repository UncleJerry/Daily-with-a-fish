//
//  SignupController.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/3/30.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class SignupController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var NextButton: ButtonView!
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var FirstNLabel: UITextField!
    @IBOutlet weak var LastNLabel: UITextField!
    @IBOutlet weak var Tips: UILabel!
    @IBOutlet weak var MaleButton: RadioBox!
    @IBOutlet weak var FemaleButton: RadioBox!
    var connected = NetworkReachabilityManager(host: "https://jerrypho.club:3223/")?.isReachable

    @IBAction func MaleTouch(_ sender: RadioBox) {
        MaleButton.doesSelected = true
        FemaleButton.doesSelected = false
        
    }
    @IBAction func FemaleTouch(_ sender: RadioBox) {
        FemaleButton.doesSelected = true
        MaleButton.doesSelected = false
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func NextStep(_ sender: ButtonView) {
        connected = NetworkReachabilityManager(host: "https://jerrypho.club:3223/")?.isReachable
        
        if !connected! {
            ErrorAlert(message: "Seems like you lose the network connection, please try later.")
        }
        
        if (FirstNLabel.text?.isEmpty)! || (LastNLabel.text?.isEmpty)! {
            ErrorAlert(message: "Please fill all fields.")
            return
        }
        
        let profile = Profile()
        profile.Firstname = FirstNLabel.text!
        profile.Lastname = LastNLabel.text!
        profile.isFemale = FemaleButton.doesSelected
        
        try! realm.write {
            realm.add(profile)
        }
        
        let parameter: Parameters = ["first": FirstNLabel.text!, "gender": FemaleButton.doesSelected ? "female" : "male", "last": LastNLabel.text!]
        
        Alamofire.request("https://jerrypho.club:3223/signup/userinfo",method: .post, parameters: parameter).validate(statusCode: 200...202).responseData { response in
            switch response.result {
            case .success:
                self.performSegue(withIdentifier: "GoToMatch", sender: nil)
            case .failure:
                self.ErrorAlert(message: "Network is not functioning.")
            }
        }
    }

    @IBAction func Back(_ sender: UIButton) {
        let status = realm.objects(Status.self)[0]
        try! realm.write {
            status.logged = false
        }
        
        Alamofire.request("https://jerrypho.club:3223/logout", method: .get).responseJSON { response in
            
            
        }
    }
}
