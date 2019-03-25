//
//  TabBarViewController.swift
//  BRAVOBET
//
//  Created by Александр on 10/9/18.
//  Copyright © 2018 Aleksandr ILIN. All rights reserved.
//

import UIKit
import Parse

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor.universalColorYellow
      tabBar.addShadow(ofColor: UIColor.black, radius: 4, offset: CGSize(width: 0.0, height: 2.0), opacity: 1.0)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


extension UIView {
    func addShadow(
        ofColor color: UIColor = UIColor.ColorBlack2,
        radius: CGFloat = 3,
        offset: CGSize = CGSize(
        width: 0,
        height: 2
        ),
        opacity: Float = 1.0
        )
    {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
}
