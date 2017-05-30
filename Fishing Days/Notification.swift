//
//  Notification.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/5/30.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import Foundation
import RealmSwift

class Notification: Object {
    dynamic var notifyTime: Date?
    dynamic var detail: String?
    dynamic var repeatModel: String?
    
    private var model: RepeatModel? {
        
        set{
            repeatModel = newValue?.rawValue
        }
        get{
            return RepeatModel(rawValue: repeatModel!)
        }
        
    }
    
}

enum RepeatModel: String {
    case EveryDay
    case EveryWeek
    case EveryMonth
    case EveryYear
}
