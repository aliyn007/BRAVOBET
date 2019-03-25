//
//  TennisTableViewCell.swift
//  BRAVOBET
//
//  Created by Александр on 05.09.2018.
//  Copyright © 2018 Aleksandr Ilyin. All rights reserved.
//

import UIKit

class TennisTableViewCell: UITableViewCell {
    @IBOutlet weak var titleTen: UILabel!
    
    @IBOutlet weak var textTen: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
