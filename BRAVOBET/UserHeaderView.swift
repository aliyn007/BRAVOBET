//
//  UserHeaderView.swift
//  BRAVOBET
//
//  Created by Александр on 05.07.2018.
//  Copyright © 2018 Aleksandr Ilyin. All rights reserved.
//

import UIKit

class UserHeaderView: UITableViewHeaderFooterView {

    
    @IBOutlet weak var fotoUser: UIImageView! {
        didSet {
            
            fotoUser.layer.cornerRadius = fotoUser.frame.size.width/2
            fotoUser.clipsToBounds = true
            fotoUser.layer.borderColor = UIColor.ColorBlack2.cgColor
            fotoUser.layer.borderWidth = 3
            
        }
    }
    
    
    @IBOutlet weak var usname: UILabel!
    
    @IBOutlet weak var headerView: UIView! {
        didSet {
            
          headerView.backgroundColor = UIColor.clear
           
        }
    }
    
    
   
    
    override func layoutSubviews() {
      //  self.headerView?.setGradientBackground(colorOne:UIColor.Black11, colorTwo: UIColor.ColorBlack2)
      
        
        
  }
}



