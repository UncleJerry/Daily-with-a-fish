//
//  NotificationCell.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/6/5.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import UIKit

class NotificationCell: GeneralCollectionCell {
    
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var RepeatLabel: UILabel!
    
    var notification: Notification! {
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI() {
        Description.text = notification.detail
        
        
        var repeatStr = "Every " + notification.getMode().rawValue
        var timeStr = ""
        switch notification.getMode() {
        case .Day:
            timeStr = String(format:"%.2d", notification.hour) + ":" + String(format:"%.2d", notification.minute)
        case .Week:
            timeStr = notification.getWeek().rawValue + " " + String(format:"%.2d", notification.hour) + ":" + String(format:"%.2d", notification.minute)
        case .Month:
            timeStr = String(notification.day) + " " + String(format:"%.2d", notification.hour) + ":" + String(format:"%.2d", notification.minute)
        case .Year:
            timeStr = String(notification.month) + "/" + String(notification.day) + " " + String(format:"%.2d", notification.hour) + ":" + String(format:"%.2d", notification.minute)
        default:
            repeatStr = "No"
            timeStr = String(notification.year) + "/" + String(notification.month) + "/" + String(notification.day) + " " + String(format:"%.2d", notification.hour) + ":" + String(format:"%.2d", notification.minute)
        }
        TimeLabel.text = timeStr
        RepeatLabel.text = repeatStr
    }
}
