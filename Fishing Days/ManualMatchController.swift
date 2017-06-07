//
//  ManualMatchController.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/6/4.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ManualMatchController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Activity.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var MatchButton: UIButton!
    @IBOutlet weak var Activity: UIActivityIndicatorView!
    
    var isFemale: Bool?
    var matchedFemale: Bool?
    var firstname: String?
    var lastname: String?
    var timer = Timer()
    var matchid: Int?
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ManualSuccess"{
            let destination: DateViewController = segue.destination as! DateViewController
            
            destination.matchedID = matchID!
        }
    }
    
    

    @IBAction func SendMatch(_ sender: UIButton) {
        if EmailField.text == nil {
            
        }
        
        let parameter: Parameters = ["target": EmailField.text!]
        
        Alamofire.request("https://jerrypho.club:3223/signup/match",method: .post, parameters: parameter).validate(statusCode: 200...202).responseJSON { response in
            switch response.result {
            case .success:
                let json = JSON(response.value!)
                
                self.firstname = json["firstname"].stringValue
                self.lastname = json["lastname"].stringValue
                self.matchedFemale = json["isFemale"].boolValue
                self.matchid = json["uid"].intValue
                self.Activity.isHidden = false
                self.Activity.startAnimating()
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.checkMatchValid)), userInfo: nil, repeats: true)
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
    func checkMatchValid() {
        let parameter: Parameters = ["match": matchid!]
        Alamofire.request("https://jerrypho.club:3223/signup/match_check",method: .post, parameters: parameter).validate(statusCode: 200...202).responseJSON { response in
            switch response.result {
            case .success:
                let json = JSON(response.value!)
                
                if json["status"].stringValue == "success"{
                    self.timer.invalidate()
                    self.performSegue(withIdentifier: "ManualSuccess", sender: nil)
                }
                
                
            case .failure(let error):
                print(error)
            }
            
            
        }
    }
    
}
