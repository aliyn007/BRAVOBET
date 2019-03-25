//
//  convertNumber.swift
//  BRAVOBET
//
//  Created by Александр on 08.09.2018.
//  Copyright © 2018 Aleksandr Ilyin. All rights reserved.
//

import UIKit

extension Double {
    
    // Formatting double value to k and M
    // 1000 = 1k
    // 1100 = 1.1k
    // 15000 = 15k
    // 115000 = 115k
    // 1000000 = 1m
    func formatPoints() -> String{
        let thousandNum = self/1000
        let millionNum = self/1000000
        if self >= 1000 && self < 1000000{
            if(floor(thousandNum) == thousandNum){
                return ("\(Int(thousandNum))k").replacingOccurrences(of: ".0", with: "")
            }
            return("\(thousandNum.roundTo(places: 1))k").replacingOccurrences(of: ".0", with: "")
        }
        if self > 1000000{
            if(floor(millionNum) == millionNum){
                return("\(Int(thousandNum))k").replacingOccurrences(of: ".0", with: "")
            }
            return ("\(millionNum.roundTo(places: 1))M").replacingOccurrences(of: ".0", with: "")
        }
        else{
            if(floor(self) == self){
                return ("\(Int(self))")
            }
            return ("\(self)")
        }
    }
    
    /// Returns rounded value for passed places
    ///
    /// - parameter places: Pass number of digit for rounded value off after decimal
    ///
    /// - returns: Returns rounded value with passed places
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}



extension Int {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(Int(number))"
        }
    }
}
