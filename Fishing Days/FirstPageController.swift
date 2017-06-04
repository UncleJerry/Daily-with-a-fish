//
//  FirstPageController.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/3/1.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit
import Alamofire

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
        // Do any additional setup after loading the view.
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
        let parameter: Parameters = ["username" : EmailField.text!, "password" : PasswdField.text ?? "?"]
        
        if action == .Signin {
            Alamofire.request("https://jerrypho.club:3223/login",method: .post, parameters: parameter).validate(statusCode: 200...202).responseData { response in
                switch response.result {
                case .success:
                    self.performSegue(withIdentifier: "LoginToDashboard", sender: nil)
                case .failure(let error):
                    print(error)
                }
            }

        }else{
            Alamofire.request("https://jerrypho.club:3223/signup",method: .post, parameters: parameter).validate(statusCode: 200...202).responseData { response in
                switch response.result {
                case .success:
                    self.performSegue(withIdentifier: "SignupInfo", sender: nil)
                case .failure(let error):
                    print(error)
                }
            }
            //self.performSegue(withIdentifier: "SignupInfo", sender: nil)
        }
        
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
