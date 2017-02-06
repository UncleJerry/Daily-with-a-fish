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
}

extension Int {
    
}
