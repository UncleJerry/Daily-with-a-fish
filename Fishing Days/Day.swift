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
        
        self.dayinfo = DayInfo(year: self.year, month: self.month, day: self.day, days: self.totalDays, thatDay: thatMoment!)
    }
    
    func printToLabel(model: CountModel) -> String{
        var str = ""
        if model == CountModel.Full {
            if year != 0 {
                str += "\(year) year"
                if year > 1 {
                    str += "s"
                }
                
                str += " "
            }
            if month != 0 {
                str += "\(month) month"
                if month > 1 {
                    str += "s"
                }
                
                str += " "
            }
            str += "\(day) day"
            
            if day > 1 {
                str += "s"
            }
            
            str += " "
            
            return str
        }else{
            str += "\(totalDays) day"
            if totalDays > 1 {
                str += "s"
            }
            str += " in total"
        }
        return str
    }
}

enum CountModel {
    case Full
    case Days
}

enum SpecialDay: String{
    case OneMonth = "Happy first month!" // 30
    case TwoMonth = "Two month ago you accept me." // 60
    case ThreeMonth // 90
    case HundredDays // == 100
    case HalfYear // 180
    case TwoHundredDays // 200
    case SmileDay // 233
    case Anniversary // 1st 💗
    
    var name: String {
        switch self {
        case .OneMonth:
            return "One Month"
        case .TwoMonth:
            return "Two Month"
        case .ThreeMonth:
            return "Three Month"
        case .HundredDays:
            return "Hundred Days"
        case .HalfYear:
            return "Half a Year"
        case .TwoHundredDays:
            return "Two Hundred Days"
        case .SmileDay:
            return "SmileDays"
        case .Anniversary:
            return "Anniversary"
        
        }
    }

}


enum Internal: String {
    case FirstMonth = "We're in very first period." // < 30
    case SecondMonth = "It's our second month." // < 60
    case ThirdMonth = " third month" //  < 90
    case Approach100 = "Whoa! Ready for hundred days?" // < 100
    case After100 = "Hundred days proves stable" // > 100
    case HalfYearLater = "Yikes! Our love has been no bug for half a year" // > 180
    case OneYear = "We've fought for our future for a year" // > 365
    case TwoYear // > 730
    case MoreThanThree
}


struct DayInfo {
    var InternalStatus: Internal?
    var SpeDay: SpecialDay?
    var NextSpeDate: Date?
    var NextSpeDay: SpecialDay?
    
    init(year:Int, month: Int, day: Int, days: Int, thatDay: Date) {
        
        if year == 0 {
            if month < 1 {
                self.InternalStatus = Internal.FirstMonth
                self.NextSpeDate = Calendar.current.date(byAdding: Calendar.Component.month, value: 1, to: thatDay)
                self.NextSpeDay = SpecialDay.OneMonth
            }else if month < 2 {
                self.InternalStatus = Internal.SecondMonth
                
                if day == 0 {
                    self.SpeDay = SpecialDay.OneMonth
                }else{
                    self.NextSpeDate = Calendar.current.date(byAdding: Calendar.Component.month, value: 2, to: thatDay)
                    self.NextSpeDay = SpecialDay.TwoMonth
                }
            }else if month < 3 {
                self.InternalStatus = Internal.ThirdMonth
                if day == 0 {
                    self.SpeDay = SpecialDay.TwoMonth
                }else{
                    self.NextSpeDate = Calendar.current.date(byAdding: Calendar.Component.month, value: 3, to: thatDay)
                    self.NextSpeDay = SpecialDay.ThreeMonth
                }
            }else if month < 6 {
                
                if month == 3 && day == 0{
                    self.SpeDay = SpecialDay.ThreeMonth
                }else if days < 100 {
                    self.NextSpeDate = Calendar.current.date(byAdding: Calendar.Component.day, value: 100, to: thatDay)
                    self.InternalStatus = Internal.Approach100
                    self.NextSpeDay = SpecialDay.HundredDays
                }else if days == 100 {
                    self.SpeDay = SpecialDay.HundredDays
                    self.InternalStatus = Internal.After100
                }else{
                    self.NextSpeDate = Calendar.current.date(byAdding: Calendar.Component.month, value: 6, to: thatDay)
                    self.InternalStatus = Internal.After100
                    self.NextSpeDay = SpecialDay.HalfYear
                }
            }else if month == 6 {
                
                if day == 0 {
                    self.SpeDay = SpecialDay.HalfYear
                }else{
                    self.NextSpeDay = SpecialDay.SmileDay
                    self.NextSpeDate = Calendar.current.date(byAdding: Calendar.Component.day, value: 233, to: thatDay)
                }
                self.InternalStatus = Internal.HalfYearLater
                
            }else if days < 233{
                self.NextSpeDate = Calendar.current.date(byAdding: Calendar.Component.day, value: 233, to: thatDay)
                self.InternalStatus = Internal.HalfYearLater
            }else if days == 233 {
                self.SpeDay = SpecialDay.SmileDay
                self.InternalStatus = Internal.OneYear
            }else{
                self.InternalStatus = Internal.OneYear
                self.NextSpeDate = Calendar.current.date(byAdding: Calendar.Component.year, value: 1, to: thatDay)
            }
        }else if year == 1 {
            if month == 0 && day == 0 {
                self.SpeDay = SpecialDay.Anniversary
            }
            self.InternalStatus = Internal.TwoYear
        }else if year == 2 {
            self.InternalStatus = Internal.MoreThanThree
        }
        
    }
}





