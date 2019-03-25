//
//  Color.swift
//  BRAVOBET
//
//  Created by Александр on 23.07.2018.
//  Copyright © 2018 Aleksandr Ilyin. All rights reserved.
//

import UIKit

import Foundation


extension UIColor {
    
    static let newBlaColor = UIColor().colorFromHex("181818")
    static let universalColorYellow = UIColor().colorFromHex("FFC100")
     static let universalColorBlackLite = UIColor().colorFromHex("434343")
     static let universalColorBlack = UIColor().colorFromHex("000000")
    static let Black11 = UIColor().colorFromHex("2F3135")
    static let ColorBlack2 = UIColor().colorFromHex("414345")
      static let whiteLiteColor = UIColor().colorFromHex("777777")
       static let newBlack1 = UIColor().colorFromHex("232526")
    static let newBlack2 = UIColor().colorFromHex("414345")
     static let liteD = UIColor().colorFromHex("#FFFAFA")
    
    
    func colorFromHex(_ hex : String) -> UIColor {
       var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6 {
            return UIColor.black
            
        }
        
        var rgb: UInt32 = 0
        Scanner(string: hexString).scanHexInt32(&rgb)
        
        
        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255 ,
                            green: CGFloat((rgb & 0x00FF00) >> 8) / 255,
                            blue: CGFloat(rgb & 0x0000FF) / 255, alpha: 1.0)
    }
    
}
