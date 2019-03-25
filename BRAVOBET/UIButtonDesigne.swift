//
//  UIButtonDesigne.swift
//  BRAVOBET
//
//  Created by Александр on 13.08.2018.
//  Copyright © 2018 Aleksandr Ilyin. All rights reserved.
//

import UIKit


@IBDesignable
public class Button: UIButton {
    @IBInspectable public var borderColor:UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    @IBInspectable public var borderWidth:CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable public var cornerRadius:CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
