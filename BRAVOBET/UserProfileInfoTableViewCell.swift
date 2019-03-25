//
//  UserProfileInfoTableViewCell.swift
//  BRAVOBET
//
//  Created by Александр on 30.06.2018.
//  Copyright © 2018 Aleksandr Ilyin. All rights reserved.
//

import UIKit

class UserProfileInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var lineUser: UILabel!
    @IBOutlet weak var cardUser: UIView! {
        didSet {
            self.cardUser.layer.cornerRadius = 5
            self.cardUser.setGradientBackground(colorOne: UIColor.Black11, colorTwo: UIColor.ColorBlack2)
            self.cardUser.layer.shadowRadius = 2;
            self.cardUser.layer.shadowOpacity = 1.0;
            self .cardUser.layer.shadowOffset = CGSize(width: 2, height: 2)
            self.cardUser.layer.shadowColor = UIColor.Black11.cgColor
            
        }
    }
    
    @IBOutlet weak var lineLogo: UIImageView! {
        didSet {
            lineLogo.tintColor = UIColor.universalColorYellow
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
