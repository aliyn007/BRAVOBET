//
//  FootTableViewCell.swift
//  BRAVOBET
//
//  Created by Александр on 04.09.2018.
//  Copyright © 2018 Aleksandr Ilyin. All rights reserved.
//

import UIKit

class FootTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var noteText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
      //  self.contentView.layer.cornerRadius = 10
      //  self.contentView.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
