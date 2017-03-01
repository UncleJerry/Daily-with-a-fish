//
//  FirstPageController.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/3/1.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit

class FirstPageController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var SignupButton: UIButton!
    @IBOutlet weak var SigninButton: UIButton!
    @IBOutlet weak var FirstLabel: UILabel!
    @IBOutlet weak var SecondLabel: UILabel!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswdField: UITextField!
    
    @IBAction func SignOperation(_ sender: UIButton) {
        
        if PasswdField.alpha == 1 {
            
        }else{
            // Remove the first scene
            FirstLabel.fadeOut(duration: 1)
            SecondLabel.fadeOut(duration: 1)
            
            PasswdField.fadeIn(duration: 1)
            EmailField.fadeIn(duration: 1)
            
            if sender.currentTitle == "Sign up" {
                SigninButton.fadeOut(duration: 1)
                SignupButton.MovePosition(duration: 1, x: -1, y: 400)
            }else{
                SignupButton.fadeOut(duration: 1)
                SigninButton.MovePosition(duration: 1, x: -1, y: 400)
            }

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
