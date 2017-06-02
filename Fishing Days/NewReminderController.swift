//
//  NewReminderController.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/5/31.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit

class NewReminderController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SaveButton.isEnabled = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var SaveButton: UIButton!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
