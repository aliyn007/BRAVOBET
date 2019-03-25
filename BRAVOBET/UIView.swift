//
//  UIView.swift
//  BRAVOBET
//
//  Created by Александр on 26.06.17.
//  Copyright © 2017 Aleksandr Ilyin. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox

extension UIView {
    
    func shake(withVibtation: Bool = false) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
        
        if withVibtation {
            if UIDevice.current.userInterfaceIdiom == .phone {
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
        }
    }
}
