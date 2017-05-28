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
    var thatDay: Date?
    
    
    init(dateString: String) {
        // Init Date & Formatter
        let now = Date()
        let dateFormatter = DateFormatter()
        
        // Build that moment
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateWithFormat = dateString + " 00:00:00"
        let thatMoment = dateFormatter.date(from: dateWithFormat)
        thatDay = thatMoment
        // Cal interval
        let interval = now.calInterval(thatDay: thatMoment!)
        self.year = interval[0]
        self.month = interval[1]
        self.day = interval[2]
        
        
        // Count the total days
        self.totalDays = now.calDays(thatDay: thatMoment!)
        
    }
    
    init(input: Day) {
        self.year = input.year
        self.day = input.day
        self.month = input.month
        self.totalDays = input.totalDays
        self.thatDay = input.thatDay
    }
    
    func getTotalDays() -> String {
        return String(totalDays) + " days"
    }
    
}



