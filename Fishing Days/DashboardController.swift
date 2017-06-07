//
//  DashboardController.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/5/25.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

class DashboardController: UIViewController {

    let profile = realm.objects(Profile.self)[0]
    var connected = NetworkReachabilityManager(host: "https://jerrypho.club:3223/")?.isReachable
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var Greetings: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Greetings.text = "Hey " + profile.Firstname + ", what's up?"
        
        let status = realm.objects(Status.self)[0]
        
        if !status.registered {
            let parameter: Parameters = ["deviceid": status.deviceid]
            Alamofire.request("https://jerrypho.club:3223/Add_device",method: .post, parameters: parameter).validate(statusCode: 200...202).responseJSON { response in
                switch response.result {
                case .success:
                    
                    try! realm.write {
                        status.registered = true
                    }
                    
                case .failure:
                    self.ErrorAlert(message: "Network is not functioning.")
                }
            }
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
    
    
    fileprivate let functions = Feature.generate()
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "AboutUs"{
            let destination: AboutUsController = segue.destination as! AboutUsController
            
            destination.daycard = DayCard(inputData: Day(dateString: profile.dateString))
        }
        
    }
    @IBAction func FunctionTouch(_ sender: FunctionButton) {
        self.performSegue(withIdentifier: sender.command!, sender: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension DashboardController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return functions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FunctionCell", for: indexPath) as! FunctionCell
        
        
        cell.function = functions[indexPath.item]
        
        return cell
    }
}

// MARK: - UIScrollViewDelegate
extension DashboardController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.CollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthWithSpace = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        
        let index = (offset.x + scrollView.contentInset.left) / cellWidthWithSpace
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthWithSpace - scrollView.contentInset.left, y: -scrollView.contentInset.top)
    }
}
