//
//  Day.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/1/24.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import Foundation

class Day {
    dynamic var year = 0
    dynamic var month = 0
    dynamic var day = 0
    dynamic var totalDays = 0
    dynamic var thatDay: Date?
    
    
    init(dateString: String) {
        // Init Date & Formatter
        let now = Date()
        let dateFormatter = DateFormatter()
        
        // Build that moment
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateWithFormat = dateString + "00:00:00"
        let thatMoment = dateFormatter.date(from: dateWithFormat)
        thatDay = thatMoment
        // Cal interval
        var interval = Calendar.current.dateComponents([Calendar.Component.year, Calendar.Component.month, Calendar.Component.day], from: thatMoment!, to: now)
        self.year = interval.year!
        self.month = interval.month!
        self.day = interval.day!
        
        
        // Count the total days
        interval = Calendar.current.dateComponents([Calendar.Component.day], from: thatMoment!, to: now)
        self.totalDays = interval.day!
        
    }
    
    init(input: Day) {
        self.year = input.year
        self.day = input.day
        self.month = input.month
        self.totalDays = input.totalDays
        self.thatDay = input.thatDay
    }
    
    
}


/*
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

*/



