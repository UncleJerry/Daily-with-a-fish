//
//  NotificationViewController.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/5/30.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class NotificationViewController: UIViewController {

    
    fileprivate let notifications = realm.objects(Notifications.self)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if notifications.count == 0 {
            NoItemLabel.isHidden = false
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshCells(notification:)), name: NSNotification.Name("RefreshCell"), object: nil)
        
        if connected! {
            Alamofire.request("https://jerrypho.club:3223/Get_Notification",method: .get).validate(statusCode: 200...202).responseJSON { response in
                switch response.result {
                case .success:
                    
                    let json = JSON(response.value!)
                    
                    if self.notifications.count == 0{
                        self.loadFromServer(jsonData: json)
                    }else{
                        self.syncNotifications(jsonData: json)
                    }
                    
                    
                    if self.notifications.count != 0 {
                        self.NoItemLabel.isHidden = true
                    }
                case .failure:
                    self.ErrorAlert(message: "Network is not functioning.")
                }
                
                
            }
        }
        
        if notifications.count == 0 {
            NoItemLabel.isHidden = false
        }
        
        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var DeleteTip: UILabel!
    @IBOutlet var CollectionView: UICollectionView!
    @IBOutlet weak var NoItemLabel: UILabel!
    @IBOutlet weak var DeleteModelButton: UIButton!
    var canDelete = false
    var connected = NetworkReachabilityManager(host: "https://jerrypho.club:3223/")?.isReachable
    
    @IBAction func DeleteModel(_ sender: UIButton) {
        
        if canDelete {
            canDelete = false
            
            DeleteTip.fadeOut(duration: 0.5)
            DeleteModelButton.rotation(angle: 0, duration: 0.5)
        }else{
            canDelete = true
            DeleteTip.fadeIn(duration: 0.5)
            DeleteModelButton.rotation(angle: Double.pi / 2, duration: 0.5)
        }
        
    }
    
    @IBAction func DeleteItem(_ sender: FunctionButton) {
        if canDelete {
            
            let alert = UIAlertController(title: "Confirm", message: "Are you sure to delete this?", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                let notification = self.notifications.filter("notifyID = %@", Int(sender.command!) ?? 0)
                try! realm.write {
                    realm.delete(notification)
                }
                
                self.CollectionView.reloadData()
                
                let parameters: Parameters = ["notifyid": sender.command!]
                
                Alamofire.request("https://jerrypho.club:3223/Delete_Notification", method: .post, parameters: parameters)
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action) in
                
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    func loadFromServer(jsonData: JSON){
        
        for (_, subJson):(String, JSON) in jsonData {
            loadSingleNotification(jsonData: subJson)
        }
        
    }
    
    func refreshCells(notification: Notification) {
        CollectionView.reloadData()
    }
    
    func loadSingleNotification(jsonData: JSON) {
        let single = Notifications()
        single.notifyID = jsonData["notifyid"].intValue
        single.detail = jsonData["detail"].stringValue
        
        let repeatNum = jsonData["repeatmodel"].intValue
        let model = single.setModel(modelNum: repeatNum)
        
        switch model {
        case .No:
            single.year = jsonData["year"].intValue
            single.month = jsonData["month"].intValue
            single.day = jsonData["day"].intValue
        case .Week:
            single.weekName = jsonData["week"].stringValue
        case .Month:
            single.day = jsonData["day"].intValue
        case .Year:
            single.month = jsonData["month"].intValue
            single.day = jsonData["day"].intValue
        default: break
            // Remain to handle error
        }
        
        single.hour = jsonData["hour"].intValue
        single.minute = jsonData["minute"].intValue
        single.localID = getUUID()
        
        try! realm.write {
            realm.add(single)
        }
        
        CollectionView.reloadData()
    }
    
    
    func syncNotifications(jsonData: JSON){
        var IDs = [Int: Int]()
        
        
        for (index,subJson):(String, JSON) in jsonData{
            IDs[subJson["notifyid"].intValue] = Int(index)
        }
        
        
        for item in notifications{
            
            guard let _ = IDs[item.notifyID] else {
                try! realm.write {
                    realm.delete(item)
                }
                
                return
            }
            
        }
        
        for (notifyID, jsonIndex) in IDs{
            if notifications.filter("notifyID = %@", notifyID).count == 0 {
                loadSingleNotification(jsonData: jsonData[jsonIndex])
            }
        }
        
        CollectionView.reloadData()
        
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


// MARK: - UICollectionViewDataSource
extension NotificationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        
        
        cell.notification = notifications[indexPath.item]
        
        return cell
    }
}

// MARK: - UIScrollViewDelegate
extension NotificationViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.CollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthWithSpace = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        
        let index = (offset.x + scrollView.contentInset.left) / cellWidthWithSpace
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthWithSpace - scrollView.contentInset.left, y: -scrollView.contentInset.top)
    }
}
