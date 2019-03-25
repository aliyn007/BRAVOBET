//
//  CommentTableViewCell.swift
//  BRAVOBET
//
//  Created by Александр on 29.09.17.
//  Copyright © 2017 Aleksandr Ilyin. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var nameAndCountry: UILabel!
    
    @IBOutlet weak var commentView: UIView!{
        didSet {
            self.commentView.layer.cornerRadius = 5
            
            self.commentView.layer.shadowRadius = 2;
            self.commentView.layer.shadowOpacity = 0;
            self.commentView.layer.shadowOffset = CGSize(width: 1, height: 1)
            
        }
    }
    
    
    @IBOutlet weak var comment: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
    
    
    
}
