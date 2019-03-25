//
//  Date.swift
//  BRAVOBET
//
//  Created by Александр on 25.12.2017.
//  Copyright © 2017 Aleksandr Ilyin. All rights reserved.
//

import Foundation
import UIKit


extension Date {
func getPastTime(for date : Date) -> String {
    
    var secondsAgo = Int(Date().timeIntervalSince(date))
    if secondsAgo < 0 {
        secondsAgo = secondsAgo * (-1)
    }
    
    let minute = 60
    let hour = 60 * minute
    let day = 24 * hour
    let week = 7 * day
    
     let sec = NSLocalizedString("cекунд назад", comment: "")
    let minut = NSLocalizedString("минут назад", comment: "")
    let hours = NSLocalizedString("час назад", comment: "")
    let dnay = NSLocalizedString("дней назад", comment: "")
    let nowSeichas = NSLocalizedString("сейчас", comment: "")
    
    if secondsAgo < minute  {
        if secondsAgo < 2{
            return nowSeichas
        }else{
            return "\(secondsAgo) \(sec)"
        }
    } else if secondsAgo < hour {
        let min = secondsAgo/minute
        if min == 1{
            return "\(min) \(minut)"
        }else{
            return "\(min) \(minut)"
        }
    } else if secondsAgo < day {
        let hr = secondsAgo/hour
        if hr == 1{
            return "\(hr) \(hours)"
        } else {
            return "\(hr) \(hours)"
        }
    } else if secondsAgo < week {
        let day = secondsAgo/day
        if day == 1{
            return "\(day) \(dnay) "
        } else {
            return "\(day) \(dnay)"
        }
    } else {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ru_UK")
        let strDate: String = formatter.string(from: date)
        return strDate
    }
    }

}

