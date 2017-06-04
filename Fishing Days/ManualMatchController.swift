//
//  ManualMatchController.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/6/4.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit
import Alamofire

class ManualMatchController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        MatchButton.isEnabled = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var MatchButton: UIButton!
    
    var isFemale: Bool?
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ManualSuccess"{
            let destination: DateViewController = segue.destination as! DateViewController
            
            destination.isFemale = isFemale
        }
    }
    
    @IBAction func CheckValid(_ sender: UITextField) {
        if (sender.text?.isEmpty)!{
            MatchButton.isEnabled = false
        }else{
            MatchButton.isEnabled = true
        }
    }

    @IBAction func SendMatch(_ sender: UIButton) {
        
        let parameter: Parameters = ["username": EmailField.text!, "gender": isFemale! ? "male": "female"]
        
        Alamofire.request("https://jerrypho.club:3223/signup/manual_match",method: .post, parameters: parameter).validate(statusCode: 200...202).responseData { response in
            switch response.result {
            case .success:
                self.performSegue(withIdentifier: "ManualSuccess", sender: nil)
            case .failure(let error):
                print(error)
            }
            
            //缺少服务器返回null的判断
        }
        
    }
}
