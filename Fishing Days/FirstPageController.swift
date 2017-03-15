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
        let user = "zhjmv6@gmail.com"
        let password = "just4test"
        
        let credential = URLCredential(user: user, password: password, persistence: .forSession)
        
        Alamofire.request("https://jerrypho.club:3000/login.html/\(user)/\(password)")
            .authenticate(usingCredential: credential)
            .responseJSON { response in
                debugPrint(response)
        }
        */
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
    
    @IBOutlet weak var SignupButton: UIButton!
    @IBOutlet weak var SigninButton: UIButton!
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
        
    }
    
    
    @IBAction func GoAction(_ sender: UIButton) {
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
