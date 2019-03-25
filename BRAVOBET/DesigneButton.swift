//
//  DesigneButton.swift
//  BRAVOBET
//
//  Created by Александр on 21.08.2018.
//  Copyright © 2018 Aleksandr Ilyin. All rights reserved.
//

import UIKit

class DesigneButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 35), bottom: 5, right: 5)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (imageView?.frame.width)!)
        }
    }
}
