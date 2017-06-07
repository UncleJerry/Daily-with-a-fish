//
//  DayCard.swift
//  Fishing Days
//
//  Created by 周建明 on 2017/5/26.
//  Copyright © 2017年 Uncle Jerry. All rights reserved.
//

import Foundation

class DayCard: Day {
    var description: String?
    var SpeDay: SpecialDay?
    var NextSpeDate: Date?
    var NextSpeDay: SpecialDay?
    
    convenience init(inputData: Day){
        self.init(input: inputData)
        if year == 0 {
            if month < 1 {
                self.NextSpeDate = Calendar.current.date(byAdding: Calendar.Component.month, value: 1, to: thatDay!)
                self.NextSpeDay = SpecialDay.OneMonth
            }else if month < 2 {
                
                if day == 0 {
                    self.SpeDay = SpecialDay.OneMonth
                }else{
                    self.NextSpeDate = Calendar.current.date(byAdding: Calendar.Component.month, value: 2, to: thatDay!)
                    self.NextSpeDay = SpecialDay.TwoMonth
                }
            }else if month < 3 {
                
                if day == 0 {
                    self.SpeDay = SpecialDay.TwoMonth
                }else{
                    self.NextSpeDate = Calendar.current.date(byAdding: Calendar.Component.month, value: 3, to: thatDay!)
                    self.NextSpeDay = SpecialDay.ThreeMonth
                }
            }else if month < 6 {
                
                if month == 3 && day == 0{
                    self.SpeDay = SpecialDay.ThreeMonth
                }else if totalDays < 100 {
                    self.NextSpeDate = Calendar.current.date(byAdding: Calendar.Component.day, value: 100, to: thatDay!)
                    
                    self.NextSpeDay = SpecialDay.HundredDays
                }else if totalDays == 100 {
                    self.SpeDay = SpecialDay.HundredDays
                    
                }else{
                    self.NextSpeDate = Calendar.current.date(byAdding: Calendar.Component.month, value: 6, to: thatDay!)
                    
                    self.NextSpeDay = SpecialDay.HalfYear
                }
            }else if month < 12 {
                
                if day == 0 {
                    self.SpeDay = SpecialDay.HalfYear
                }else{
                    self.NextSpeDay = SpecialDay.Anniversary
                    self.NextSpeDate = Calendar.current.date(byAdding: Calendar.Component.day, value: 233, to: thatDay!)
                }
                
                
            }else{
                
                self.NextSpeDate = Calendar.current.date(byAdding: Calendar.Component.year, value: 1, to: thatDay!)
            }
        }else if year == 1 {
            if month == 0 && day == 0 {
                self.SpeDay = SpecialDay.Anniversary
            }
            
        }else if year == 2 {
            
        }
    }
    
    
    func getCurrentSpecial() -> String? {
        
        guard let special = SpeDay else{
            return nil
        }
        
        return special.rawValue
    }
    
    func getNextSpecial() -> String {
        return NextSpeDay!.rawValue
    }
    
    func getNextSpeDate() -> Date {
        return NextSpeDate!
    }
    
    func checkToday() -> Bool {
        return SpeDay != nil
    }
}



enum SpecialDay: String{
    case OneMonth = "One Month" // 30
    case TwoMonth = "Two Month" // 60
    case ThreeMonth = "Three Month" // 90
    case HundredDays = "Hundred Days" // == 100
    case HalfYear = "Half a Year" // 180
    case TwoHundredDays = "Two Hundred Days" // 200
    case Anniversary = "Anniversary" // 1st 💗
    
}
