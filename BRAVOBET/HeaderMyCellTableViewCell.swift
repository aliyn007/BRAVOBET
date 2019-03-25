//
//  HeaderMyCellTableViewCell.swift
//  BRAVOBET
//
//  Created by Александр on 13.09.2018.
//  Copyright © 2018 Aleksandr Ilyin. All rights reserved.
//

import UIKit

class HeaderMyCellTableViewCell: UITableViewCell {
    @IBOutlet weak var imagePhoto: UIImageView!{
        didSet {
            
            self.imagePhoto.layer.borderColor = UIColor.white.cgColor
            self.imagePhoto.layer.cornerRadius = imagePhoto.frame.size.width/2
          
            self.imagePhoto.layer.borderWidth = 3
            self.imagePhoto.layer.masksToBounds = true
            self.imagePhoto.clipsToBounds = true
            
            
        }
    }
    
    @IBOutlet weak var victory: UILabel!
    @IBOutlet weak var clappingCount: UILabel!

    @IBOutlet weak var sendingMail: UILabel!
    

    @IBOutlet weak var userMyName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
