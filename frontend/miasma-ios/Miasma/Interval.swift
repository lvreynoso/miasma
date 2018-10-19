//
//  Interval.swift
//  Miasma
//
//  Created by Lucia Reynoso on 10/18/18.
//  Copyright © 2018 Lucia Reynoso. All rights reserved.
//

import Foundation
import UIKit

class Interval {
    
    static func until(_ deadline: Date) -> String {
        var interval: String = ""
        var years: Int = 0
        var months: Int = 0
        var days: Int = 0
        var hours: Int = 0
        var minutes: Int = 0
        var seconds: Int = 0
        
        let yearGetter = DateFormatter()
        yearGetter.dateFormat = "yyyy"
        var year = Int(yearGetter.string(from: deadline))!
        
        // interval in seconds
        let now = Date()
        var timeInterval = Int(deadline.timeIntervalSince(now))
        
        let commonYear: Int = 31536000
        let leapYear: Int = 31622400
        
        struct Months {
            let thirtyOne: Int = 2678400
            let thirty: Int = 2592000
            let twentyNine: Int = 2505600
            let twentyEight: Int = 2419200
        }
        
        let monthSeconds = Months.init()
        
        var timeIsMoreThanOneYear: Bool = true
        var timeIsMoreThanOneMonth: Bool = true
        
        // first we whittle down the years
        // 2034 & 2035 are common years
        
        while timeIsMoreThanOneYear {
            switch year {
            case 2020, 2024, 2028, 2032:
                if timeInterval > leapYear {
                    timeInterval -= leapYear
                    years += 1
                    year -= 1
                } else {
                    timeIsMoreThanOneYear = false
                }
            default:
                if timeInterval > commonYear {
                    timeInterval -= commonYear
                    years += 1
                    year -= 1
                } else {
                    timeIsMoreThanOneYear = false
                }
            }
        }
        
        // then we whittle down the months
        let monthGetter = DateFormatter()
        monthGetter.dateFormat = "MM"
        
        let currentMonth = Int(monthGetter.string(from: now))!
        
        // check if the time remaining is more than what's in next month
        var nextMonth = (currentMonth + 1) % 12
        
        // whittle it down
        while timeIsMoreThanOneMonth {
            switch nextMonth {
            case 01, 03, 05, 07, 08, 10, 12:
                if timeInterval > monthSeconds.thirtyOne {
                   timeInterval -= monthSeconds.thirtyOne
                    months += 1
                    nextMonth = (nextMonth + 1) % 12
                } else {
                    timeIsMoreThanOneMonth = false
                }
            case 04, 06, 09, 11:
                if timeInterval > monthSeconds.thirty {
                    timeInterval -= monthSeconds.thirty
                    months += 1
                    nextMonth = (nextMonth + 1) % 12
                } else {
                    timeIsMoreThanOneMonth = false
                }
            case 02:
                switch year {
                case 2020, 2024, 2028, 2032:
                    if timeInterval > monthSeconds.twentyNine {
                        timeInterval -= monthSeconds.twentyNine
                        months += 1
                        nextMonth = (nextMonth + 1) % 12
                    } else {
                        timeIsMoreThanOneMonth = false
                    }
                default:
                    if timeInterval > monthSeconds.twentyEight {
                        timeInterval -= monthSeconds.twentyEight
                        months += 1
                        nextMonth = (nextMonth + 1) % 12
                    } else {
                        timeIsMoreThanOneMonth = false
                    }
                }
            default:
                if timeInterval > monthSeconds.twentyEight {
                    timeInterval -= monthSeconds.twentyEight
                    months += 1
                    nextMonth = (nextMonth + 1) % 12
                } else {
                    timeIsMoreThanOneMonth = false
                }
            }
        }
        
        // now to take care of any remaining days, hours, minutes, and seconds
        
        days = timeInterval / 86400
        timeInterval -= days * 86400
        
        hours = timeInterval / 3600
        timeInterval -= hours * 3600
        
        minutes = timeInterval / 60
        timeInterval -= minutes * 60
        
        seconds = timeInterval
        
        interval = "\(years)\n\(months)\n\(days)\n\(hours)\n\(minutes)\n\(seconds)"
        
        return interval
    }
    
}
