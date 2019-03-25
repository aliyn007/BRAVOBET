//
//  ViewDesigne.swift
//  BRAVOBET
//
//  Created by Александр on 27.08.2018.
//  Copyright © 2018 Aleksandr Ilyin. All rights reserved.
//

import UIKit

class ViewDesigne: UIView {

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(UIColor.Black11.cgColor)
        context?.move(to: CGPoint(x: 0, y: 0))
        context?.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        context?.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height-self.bounds.height/4))
        context?.addQuadCurve(to: CGPoint(x: 0, y: self.bounds.height-self.bounds.height/4), control: CGPoint(x: self.bounds.width/2, y: frame.height*1.20))
        context?.closePath()
      //  let color = UIColor.whiteLiteColor
       // context?.setShadow(offset: CGSize(width: 3, height: 5), blur: 7, color: color.cgColor)
        
        context?.fillPath()
    }

}
