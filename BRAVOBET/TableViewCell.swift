//
//  TableViewCell.swift
//  BRAVOBET
//
//  Created by Александр on 12.09.17.
//  Copyright © 2017 Aleksandr Ilyin. All rights reserved.
//

import UIKit



class TableViewCell: UITableViewCell {

    
   
    
    @IBOutlet weak var titleSport: UILabel!
    @IBOutlet weak var imageMatch: UIImageView! {
        didSet {
           // imageMatch.layer.cornerRadius = imageMatch.frame.size.width/2
          //  imageMatch.clipsToBounds = true
        //    imageMatch.layer.borderColor = UIColor.universalColorYellow.cgColor
        //    imageMatch.layer.borderWidth = 2
        }
    }
    @IBOutlet weak var resultSoccer: UIImageView! {
        didSet {
            resultSoccer.tintColor = UIColor.lightGray
        }
    }
    
    @IBOutlet weak var imageSport: UIImageView! {
        didSet {
            imageSport.tintColor = UIColor.universalColorYellow
        }
    }
    
    @IBOutlet weak var matchLabel: UILabel!
    
    @IBOutlet weak var viewsImage: UIImageView! {
        didSet {
            
            viewsImage.tintColor = UIColor.universalColorYellow
        }
    }
    
    @IBOutlet weak var viewsCounter: UILabel!
    
    
    @IBOutlet weak var bravoImage: UIImageView!{
        didSet {
            
            bravoImage.tintColor = UIColor.universalColorYellow
        }
    }
   
    @IBOutlet weak var bravoCounter: UILabel!
    
  
    @IBOutlet weak var shareImage: UIImageView! {
        didSet {
            
            shareImage.tintColor = UIColor.universalColorYellow
        }
    }
    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var shareCounter: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

    override func layoutSubviews() {
       
        
        self.cardView.layer.cornerRadius = 5
      //  self.cardView.setGradientBackground(colorOne: UIColor.newBlack1, colorTwo: UIColor.newBlack2)
        self.cardView.layer.shadowRadius = 2;
        self.cardView.layer.shadowOpacity = 1.0;
        self .cardView.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.cardView.layer.shadowColor = UIColor.black.cgColor
       
        
    }
 
   
    

}
