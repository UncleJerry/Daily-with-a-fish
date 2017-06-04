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

        SubmitButton.isEnabled = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var SubmitButton: UIButton!
    @IBOutlet weak var DatePicker: UIDatePicker!
    var isFemale: Bool?
    var matchedID: Int?
    
    @IBAction func ValueChanged(_ sender: UIDatePicker) {
        SubmitButton.isEnabled = true
    }
    @IBAction func Submit(_ sender: UIButton) {
        let dateString = DatePicker.date.toString
        
        let parameter: Parameters = ["matched": matchedID!, "gender": isFemale! ? "female" : "male", "date": dateString]
        
        Alamofire.request("https://jerrypho.club:3223/signup/match_complete",method: .post, parameters: parameter).validate(statusCode: 200...202).responseData { response in
            switch response.result {
            case .success:
                let date = DateData()
                date.dateString = dateString
                
                try! realm.write {
                    realm.add(date)
                }
                
                self.performSegue(withIdentifier: "MatchFinished", sender: nil)
            case .failure(let error):
                print(error)
            }
        }
    }

}
