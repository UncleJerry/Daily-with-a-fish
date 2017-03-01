//
//  Extension.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/1/24.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    var toString: String{
        get{
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            formatter.locale = Locale(identifier: "en-us")
            
            return formatter.string(from: self)
        }
    }
}

extension UIView {
    
    
    func fadeIn(duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    func fadeOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
    
    func MovePosition(duration: TimeInterval, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        
        UIView.animate(withDuration: duration, animations: {
            self.frame = CGRect(x: x, y: y, width: self.frame.width, height: self.frame.height)
        })
        
    }
}

extension Int {
    
}
