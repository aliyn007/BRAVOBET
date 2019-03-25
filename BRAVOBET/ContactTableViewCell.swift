//
//  ContactTableViewCell.swift
//  BRAVOBET
//
//  Created by Александр on 07.05.2018.
//  Copyright © 2018 Aleksandr Ilyin. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewHeaderFooterView {
 
    
    
    @IBOutlet weak var sendMessageCount: UILabel!
    
    @IBOutlet weak var likeCountProfile: UILabel?
    @IBOutlet weak var userMyFoto: UIImageView!
    
    @IBOutlet weak var nameUserProfile: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.userMyFoto.layer.borderColor = UIColor.white.cgColor
        self.userMyFoto.layer.cornerRadius = userMyFoto.frame.size.width/2
        self.userMyFoto.isUserInteractionEnabled = true
        self.userMyFoto.layer.borderWidth = 3
        self.userMyFoto.layer.masksToBounds = true
        self.userMyFoto.clipsToBounds = true
    }

    
    
}
