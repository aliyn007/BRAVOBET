//
//  DesigneUITextField.swift
//  BRAVOBET
//
//  Created by Александр on 18.07.2018.
//  Copyright © 2018 Aleksandr Ilyin. All rights reserved.
//

import UIKit

@IBDesignable
class DesigneUITextField: UITextField {
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            let view = UIView(frame : CGRect(x: 0, y: 0, width: 25, height: 20))
            view.addSubview(imageView)
            leftView = view
            
            //leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            //leftView = nil
        }
        
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
}
