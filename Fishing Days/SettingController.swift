//
//  SettingController.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/5/29.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import SwiftyJSON
import MessageUI

class SettingController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var CollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate let settings = Setting.generate()
    var connected = NetworkReachabilityManager(host: "https://jerrypho.club:3223/")?.isReachable
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @IBAction func SwitchChange(_ sender: UISwitch) {
        let defaults: UserDefaults = UserDefaults.standard
        
        if defaults.bool(forKey: "DisplayTotalDays") {
            defaults.set(false, forKey: "DisplayTotalDays")
        }else{
            defaults.set(true, forKey: "DisplayTotalDays")
        }
    }
    
    @IBAction func ButtonClick(_ sender: FunctionButton) {
        if sender.command == "email" {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            // Configure the fields of the interface.
            composeVC.setToRecipients(["jerrychou233@gmail.com"])
            composeVC.setSubject("Hello from BeTouched user!")
            composeVC.setMessageBody(" ", isHTML: false)
            // Present the view controller modally.
            self.present(composeVC, animated: true, completion: nil)
        }else if sender.command == "Logout"{
            
            let alert = UIAlertController(title: "Confirm", message: "Are you sure to log out?", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                
                let status = realm.objects(Status.self)[0]
                try! realm.write {
                    status.logged = false
                }
                
                Alamofire.request("https://jerrypho.club:3223/logout", method: .get).responseJSON { response in
                    _ = JSON(response.value!)
                    
                    
                }
                
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action) in
                
            }))
            
            
        }
    }
    
    @IBAction func EndEdit(_ sender: UITextField) {
        connected = NetworkReachabilityManager(host: "https://jerrypho.club:3223/")?.isReachable
        
        if !connected! {
            return
        }
        
        let profile = realm.objects(Profile.self)[0]
        let tokens = sender.text!.components(separatedBy: " ")
        try! realm.write {
            profile.Firstname = tokens[0]
            if tokens.count > 1{
                profile.Lastname = tokens[1]
            }else{
                profile.Lastname = ""
            }
            
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
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


extension SettingController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SettingCell", for: indexPath) as! SettingCell
        
        cell.setting = settings[indexPath.item]
        
        if indexPath.item == 0 {
            cell.profile = realm.objects(Profile.self)[0]
        }
        
        return cell
    }
}

// MARK: - UIScrollViewDelegate
extension SettingController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.CollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthWithSpace = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        
        let index = (offset.x + scrollView.contentInset.left) / cellWidthWithSpace
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthWithSpace - scrollView.contentInset.left, y: -scrollView.contentInset.top)
    }
}
