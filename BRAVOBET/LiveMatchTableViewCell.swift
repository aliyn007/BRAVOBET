//
//  LiveMatchTableViewCell.swift
//  BRAVOBET
//
//  Created by Александр on 10/28/18.
//  Copyright © 2018 Aleksandr ILIN. All rights reserved.
//

import UIKit

class LiveMatchTableViewCell: UITableViewCell {
    @IBOutlet weak var timePost: UILabel!
    @IBOutlet weak var live: UILabel!
    
    @IBOutlet weak var betMatch: UILabel!
    @IBOutlet weak var nameMatch: UILabel!
    @IBOutlet weak var viewDesgn: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        
        
        self.viewDesgn.layer.cornerRadius = 5
        //  self.cardView.setGradientBackground(colorOne: UIColor.newBlack1, colorTwo: UIColor.newBlack2)
        self.viewDesgn.layer.shadowRadius = 2;
        self.viewDesgn.layer.shadowOpacity = 1.0;
        self.viewDesgn.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.viewDesgn.layer.shadowColor = UIColor.black.cgColor
        
        
    }

}
