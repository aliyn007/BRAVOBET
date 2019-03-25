//
//  InfoTableViewCell.swift
//  BRAVOBET
//
//  Created by Александр on 10.07.2018.
//  Copyright © 2018 Aleksandr Ilyin. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    @IBOutlet weak var titleProfile: UILabel!
    
    @IBOutlet weak var cardViewProfile: UIView!{
        didSet{
            
        }
    }
    @IBOutlet weak var infogdevice: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cardViewProfile.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
    extension UIView {
        func round(corners: UIRectCorner, withRadius radius: CGFloat) {
            let mask = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let shape = CAShapeLayer()
            shape.frame = self.bounds
            shape.path = mask.cgPath
            self.layer.mask = shape
        }
    }

    

