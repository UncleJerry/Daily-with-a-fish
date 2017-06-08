//
//  FirstPageController.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/3/1.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import SwiftyJSON

class FirstPageController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        Alamofire.request("https://jerrypho.club:3000/verify").validate(statusCode: 200...202).responseData { (response) in
            debugPrint(response)
            
            switch response.result {
            case .success:
                self.performSegue(withIdentifier: "LoginToDashboard", sender: nil)
            case .failure(let error):
                print(error)
            }
        }*/
        DispatchQueue.main.async(execute: {
            let status = realm.objects(Status.self)
            if status.count != 0{
                
                if status[0].logged {
                    self.performSegue(withIdentifier: "LoginToDashboard", sender: nil)
                }
            }
        });
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        GoButton.alpha = 0
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    enum Action {
        case Signin
        case Signup
    }
    
    var action: Action!
    
    var connected = NetworkReachabilityManager(host: "https://jerrypho.club:3223/")?.isReachable
    @IBOutlet weak var SignupButton: ButtonView!
    @IBOutlet weak var SigninButton: ButtonView!
    @IBOutlet weak var FirstLabel: UILabel!
    @IBOutlet weak var SecondLabel: UILabel!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswdField: UITextField!
    @IBOutlet weak var GoButton: UIButton!
    
    @IBAction func SignOperation(_ sender: UIButton) {
        
        FirstLabel.fadeOut(duration: 0.5)
        SecondLabel.fadeOut(duration: 0.5)
        
        PasswdField.fadeIn(duration: 0.5)
        EmailField.fadeIn(duration: 0.5)
        
        EmailField.becomeFirstResponder()
        
        GoButton.fadeIn(duration: 0.5)
        
        if sender.currentTitle == "Sign up" {
            action = .Signup
        }else{
            action = .Signin
        }
        
    }
    
    
    @IBAction func GoAction(_ sender: UIButton) {
        
        connected = NetworkReachabilityManager(host: "https://jerrypho.club:3223/")?.isReachable
        
        if !connected! {
            
            ErrorAlert(message: "Seems like you have no connection, please try again later.")
            // Calcel the Action
            return
        }
        
        let parameter: Parameters = ["username" : EmailField.text!, "password" : PasswdField.text ?? "?"]
        
        if action == .Signin {
            Alamofire.request("https://jerrypho.club:3223/login",method: .post, parameters: parameter).validate(statusCode: 200...202).responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(response.value!)
                    if json["status"].stringValue == "failed"{
                        self.ErrorAlert(message: "Wrong email or password")
                        return 
                    }
                    let status = realm.objects(Status.self)
                    
                    if status.count == 0{
                        let newStatus = Status()
                        try! realm.write {
                            realm.add(newStatus)
                        }
                    }
                    
                    try! realm.write {
                        status[0].logged = true
                    }
                    
                    let newProfile = Profile()
                    
                    newProfile.Firstname = json["firstname"].stringValue
                    newProfile.Lastname = json["lastname"].stringValue
                    
                    let fullDateString = json["theday"].stringValue
                    let range: Range = fullDateString.startIndex..<fullDateString.index(fullDateString.startIndex, offsetBy: 10)
                    newProfile.dateString = fullDateString.substring(with: range)
                    
                    newProfile.matchedFName = json["mfname"].stringValue
                    newProfile.matchedLName = json["mlname"].stringValue
                    
                    if json["female"].stringValue == "true" {
                        newProfile.isFemale = true
                    }
                    if json["mfemale"].stringValue == "true" {
                        newProfile.matchedFemale = true
                    }
                    
                    try! realm.write {
                        realm.add(newProfile)
                    }
                    
                    
                    self.performSegue(withIdentifier: "LoginToDashboard", sender: nil)
                case .failure:
                    self.ErrorAlert(message: "Network is not functioning.")
                }
            }

        }else{
            Alamofire.request("https://jerrypho.club:3223/signup",method: .post, parameters: parameter).validate(statusCode: 200...202).responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(response.value!)
                    
                    if json["status"].stringValue == "exist"{
                        self.ErrorAlert(message: "The email has already existed.")
                    }else{
                        self.performSegue(withIdentifier: "SignupInfo", sender: nil)
                    }
                    
                case .failure:
                    self.ErrorAlert(message: "Network is not functioning.")
                }
            }
            
        }
        
    }


}
