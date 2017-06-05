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
    
    dynamic var notifyID = 0
    dynamic var detail: String?
    dynamic var repeatModel: String?
    dynamic var year = 0
    dynamic var month = 0
    dynamic var day = 0
    dynamic var weekName: String?
    dynamic var hour = 0
    dynamic var minute = 0
    
    private var model: RepeatModel? {
        set{
            repeatModel = newValue?.rawValue
        }
        get{
            return RepeatModel(rawValue: repeatModel!)
        }
        
    }
    
    private var week: Week? {
        set{
            weekName = newValue?.rawValue
        }
        get{
            return Week(rawValue: weekName!)
        }
        
    }
    
    func setModel(modelNum: Int) -> RepeatModel {
        print(modelNum)
        switch modelNum {
        case 0:
            self.model = .No
        case 1:
            self.model = .Day
        case 2:
            self.model = .Week
        case 3:
            self.model = .Month
        case 4:
            self.model = .Year
        default:
            self.model = .No
        }
        
        return self.model!
    }
    
    func getMode() -> RepeatModel {
        return self.model!
    }
    
    func getWeek() -> Week {
        return self.week!
    }
    
}

enum RepeatModel: String {
    case No
    case Day
    case Week
    case Month
    case Year
}
enum Week: String {
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday
}
