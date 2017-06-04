//
//  MatchViewController.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/5/31.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class MatchViewController: UIViewController, CLLocationManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.shared.applicationSupportsShakeToEdit = true
        becomeFirstResponder()
        
        let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.rotation")
        let angle = Double.pi / 6.0
        
        shakeAnimation.values = [angle, -angle, angle]
        shakeAnimation.keyTimes = [NSNumber(value: 0), NSNumber(value: 0.5), NSNumber(value: 1)]
        shakeAnimation.duration = 3
        shakeAnimation.repeatCount = MAXFLOAT
        //设置动画执行效果
        shakeAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)]
        //设置相邻动画过渡方式
        shakeAnimation.calculationMode = kCAAnimationCubic
        
        
        Image.layer.add(shakeAnimation, forKey: "Shake")
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    var timer = Timer()
    var location: Coordinate?
    
    @IBOutlet weak var Image: UIImageView!
    override public func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.delegate = self as CLLocationManagerDelegate
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            startLocation = nil
            
            // Put it in shake
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateMatchQueue), userInfo: nil, repeats: true)
        }
    }
    
    override public func motionCancelled(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            
        }
    }
    
    override public func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            
        }
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latestLocation: CLLocation = locations[locations.count - 1]
        print("latitude")
        print(latestLocation.coordinate.latitude)
        print("longitude")
        print(latestLocation.coordinate.longitude)
        
        location = Coordinate(latitude: latestLocation.coordinate.latitude, longitude: latestLocation.coordinate.longitude)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func updateMatchQueue(){
        Alamofire.request("https://jerrypho.club:3223/signup/manual_match").responseJSON { response in
            debugPrint(response)
            
            if let json = response.result.value {
                print("JSON: \(json)")
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


struct Coordinate {
    var latitude: Double?
    var longitude: Double?
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
