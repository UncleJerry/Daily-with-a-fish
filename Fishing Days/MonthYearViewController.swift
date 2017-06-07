//
//  MonthYearViewController.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/6/6.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import SwiftyJSON

class MonthYearViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if model == 0 {
            TipLabel.text = "When to remind?"
        }
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
    
    var model: Int?
    var detail: String?
    var connected = NetworkReachabilityManager(host: "https://jerrypho.club:3223/")?.isReachable
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var TipLabel: UILabel!
    
    @IBAction func SaveNotification(_ sender: UIButton) {
        
        connected = NetworkReachabilityManager(host: "https://jerrypho.club:3223/")?.isReachable
        
        if !connected! {
            ErrorAlert(message: "Seems like you have no connection, please try again later.")
            
            return
        }
        
        let dateArray = DatePicker.date.toIntArray
        let newNotify = Notifications()
        let uuid = getUUID()
        newNotify.localID = uuid
        newNotify.detail = detail
        newNotify.minute = dateArray[4]
        newNotify.hour = dateArray[3]
        newNotify.day = dateArray[2]
        
        if model == 0 || model == 4{
            newNotify.month = dateArray[1]
            
            if model == 0 {
                newNotify.year = dateArray[0]
            }
        }
        
        let _ = newNotify.setModel(modelNum: model!)
        try! realm.write {
            realm.add(newNotify)
        }
        let parameter: Parameters = ["year": dateArray[0], "month": dateArray[1], "day": dateArray[2], "hour": dateArray[3], "minute": dateArray[4], "repeat": model ?? 0, "detail": detail ?? "No content"]
        Alamofire.request("https://jerrypho.club:3223/Add_Notification",method: .post, parameters: parameter).validate(statusCode: 200...202).responseJSON { response in
            switch response.result {
            case .success:
                let json = JSON(response.value!)
                let notifyid = json["notifyid"].intValue
                
                let notification = realm.objects(Notifications.self).filter("localID = %@", uuid)
                try! realm.write {
                    notification[0].notifyID = notifyid
                }
                
                
                
            case .failure:
                self.ErrorAlert(message: "Network is not functioning.")
            }
        }
        NotificationCenter.default.post(name: NSNotification.Name("RefreshCell"), object: nil)
        self.performSegue(withIdentifier: "AddSuccess", sender: nil)
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ReturnDetailPage" {
            let destination: NewReminderController = segue.destination as! NewReminderController
            
            destination.detail = detail
        }
    }

}
