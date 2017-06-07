//
//  LeftSegue.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/6/7.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit

class LeftSegue: UIStoryboardSegue {
    override func perform() {
        // Assign the source and destination views to local variables.
        let firstVCView = self.source.view as UIView!
        let secondVCView = self.destination.view as UIView!
        
        // Get the screen width and height.
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        // Specify the initial position of the destination view.
        secondVCView?.frame = CGRect(x: -screenWidth, y: 0.0, width: screenWidth, height: screenHeight)
        
        // Access the app's key window and insert the destination view above the current (source) one.
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(secondVCView!, aboveSubview: firstVCView!)
        
        
        // Animate the transition.
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            firstVCView?.frame = (firstVCView?.frame.offsetBy(dx: screenWidth, dy: 0.0))!
            secondVCView?.frame = (secondVCView?.frame.offsetBy(dx: screenWidth, dy: 0.0))!
            
        }, completion: { (Finished) -> Void in
            self.source.present(self.destination as UIViewController,
                                animated: false,
                                completion: nil)
        })
    }
}
