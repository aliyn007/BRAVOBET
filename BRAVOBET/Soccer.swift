//
//  Betting.swift
//  BRAVOBET
//
//  Created by Александр on 15.08.17.
//  Copyright © 2017 Aleksandr Ilyin. All rights reserved.
//

import Foundation
import Parse


class Soccer : PFObject,PFSubclassing {
   
   

    @NSManaged var matchS: String
    
    @NSManaged var imagePrS: PFFile
    @NSManaged var following: Int
    @NSManaged var bravissimo: Int
    @NSManaged var shares:Int
    @NSManaged var boolean: PFFile
    @NSManaged var resultS: PFFile
    @NSManaged var textSoccer : String
    @NSManaged var footbalTitle : String
    @NSManaged var rezString : String
    
    @NSManaged var detailPrognozS: String
 
    
 
    
    
     class func parseClassName() -> String {
        
        return "Soccer"
    }
}


