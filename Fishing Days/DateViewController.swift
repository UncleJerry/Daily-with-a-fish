//
//  DateViewController.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/6/4.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit
import Alamofire

class DateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DatePicker.setValue(UIColor.white, forKey: "textColor")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var SubmitButton: UIButton!
    @IBOutlet weak var DatePicker: UIDatePicker!
    var matchedFemale: Bool?
    var matchedID: Int?
    var connected = NetworkReachabilityManager(host: "https://jerrypho.club:3223/")?.isReachable
    
    
    
    @IBAction func Submit(_ sender: UIButton) {
        connected = NetworkReachabilityManager(host: "https://jerrypho.club:3223/")?.isReachable
        
        if !connected! {
            NoConnection(message: "Seems like you lose the network connection, please try later.")
            return
        }
        
        let dateString = DatePicker.date.toString
        
        let parameter: Parameters = ["matched": matchedID!, "date": dateString]
        
        Alamofire.request("https://jerrypho.club:3223/signup/match_complete",method: .post, parameters: parameter).validate(statusCode: 200...202).responseData { response in
            switch response.result {
            case .success:
                let profile = realm.objects(Profile.self)
                
                try! realm.write {
                    profile[0].dateString = dateString
                }
                
                self.performSegue(withIdentifier: "MatchFinished", sender: nil)
            case .failure(let error):
                print(error)
            }
        }
    }

}
