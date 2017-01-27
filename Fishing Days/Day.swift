//
//  Day.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/1/24.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import Foundation

class Day {
    var year = 0
    var month = 0
    var day = 0
    var totalDays = 0
    var dayinfo: DayInfo
    
    
    init() {
        // Init Date & Formatter
        let now = Date()
        let dateFormatter = DateFormatter()
        
        // Build that moment
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = "2017-01-23 00:00:00"
        let thatMoment = dateFormatter.date(from: dateString)
        
        // Cal interval
        var interval = Calendar.current.dateComponents([Calendar.Component.year, Calendar.Component.month, Calendar.Component.day], from: thatMoment!, to: now)
        self.year = interval.year!
        self.month = interval.month!
        self.day = interval.day!
        
        
        interval = Calendar.current.dateComponents([Calendar.Component.day], from: thatMoment!, to: now)
        self.totalDays = interval.day!
        
        self.dayinfo = DayInfo(year: self.year, month: self.month, day: self.day, days: self.totalDays)
    }
    
    func printToLabel(model: CountModel) -> String{
        var str = "我们已经在一起"
        if year != 0 {
            str += "\(self.year)年"
        }
        if month != 0 {
            str += "\(self.month)个月"
        }
        str += "\(self.day)天啦"
        
        return str
    }
}

enum CountModel {
    case Full
    case Days
}

enum SpecialDay{
    case OneMonth // 30
    case TwoMonth // 60
    case ThreeMonth // 90
    case HundredDays // == 100
    case HalfYear // 180
    case TwoHundredDays // 200
    case SmileDay // 233
    case Anniversary // 1st 💗

}

struct DayInfo {
    var InternalStatus: Internal?
    var SpeDay: SpecialDay?
    
    init(year:Int, month: Int, day: Int, days: Int) {
        
        if year == 0 {
            if month < 1 {
                self.InternalStatus = Internal.FirstMonth
                
                
            }else if month < 2 {
                self.InternalStatus = Internal.SecondMonth
                
                if day == 0 {
                    self.SpeDay = SpecialDay.OneMonth
                }
            }else if month < 3 {
                self.InternalStatus = Internal.ThirdMonth
                if day == 0 {
                    self.SpeDay = SpecialDay.TwoMonth
                }
            }else if month < 6 {
                if days < 100 {
                    self.InternalStatus = Internal.Approach100
                }else if days == 100 {
                    self.SpeDay = SpecialDay.HundredDays
                }else{
                    self.InternalStatus = Internal.After100
                }
            }else if month == 6 {
                if day == 0 {
                    self.SpeDay = SpecialDay.HalfYear
                }else{
                    self.InternalStatus = Internal.HalfYearLater
                }
                
            }
            if days == 233 {
                self.SpeDay = SpecialDay.SmileDay
            }
        }else if year == 1 {
            if month == 0 && day == 0 {
                self.SpeDay = SpecialDay.Anniversary
            }
            self.InternalStatus = Internal.OneYear
        }else if year == 2 {
            self.InternalStatus = Internal.TwoYear
        }else{
            self.InternalStatus = Internal.MoreThanThree
        }
        
    }
}

enum Internal {
    case FirstMonth // < 30
    case SecondMonth // < 60
    case ThirdMonth //  < 90
    case Approach100 // < 100
    case After100 // > 100
    case HalfYearLater // > 180
    case OneYear // > 365
    case TwoYear // > 730
    case MoreThanThree
}

