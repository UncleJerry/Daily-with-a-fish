//
//  MatchViewController.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/5/31.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit
import CoreLocation

class MatchViewController: UIViewController, CLLocationManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.shared.applicationSupportsShakeToEdit = true
        becomeFirstResponder()
        
        let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.rotation")
        //设置晃动角度
        let angle = Double.pi / 6.0
        //设置关键帧动画的值
        shakeAnimation.values = [angle, -angle, angle]
        //设置关键帧动画每帧的执行时间，这里不设置也行，默认平均分配时间
        shakeAnimation.keyTimes = [NSNumber(value: 0), NSNumber(value: 0.5), NSNumber(value: 1)]
        //设置动画重复次数，默认为1次
        shakeAnimation.duration = 3
        shakeAnimation.repeatCount = MAXFLOAT
        //设置动画执行效果
        shakeAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)]
        //设置相邻动画过渡方式
        shakeAnimation.calculationMode = kCAAnimationCubic
        //添加动画
        Image.layer.add(shakeAnimation, forKey: "Shake")
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self as CLLocationManagerDelegate
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        startLocation = nil
        
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
    @IBOutlet weak var Image: UIImageView!
    override public func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            
        }
    }
    
    override public func motionCancelled(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            //Image.layer.removeAnimation(forKey: "Shake")
        }
    }
    
    override public func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            //Image.layer.removeAnimation(forKey: "Shake")
        }
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latestLocation: CLLocation = locations[locations.count - 1]
        print("latitude")
        print(latestLocation.coordinate.latitude)
        print("longitude")
        print(latestLocation.coordinate.longitude)
        /*
        horizontalAccuracy.text = String(format: "%.4f", latestLocation.horizontalAccuracy)
        altitude.text = String(format: "%.4f", latestLocation.altitude)
        verticalAccuracy.text = String(format: "%.4f", latestLocation.verticalAccuracy)*/
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
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
