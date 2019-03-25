//
//  UITextField.swift
//  BRAVOBET
//
//  Created by Александр on 26.06.17.
//  Copyright © 2017 Aleksandr Ilyin. All rights reserved.
//


import Foundation
import UIKit

extension UITextField {
    
    public var deleteSideSpaces : String {
        return self.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {return self.placeHolderColor}
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    public var isEmpty: Bool {
        return self.deleteSideSpaces == ""
    }
    
}
