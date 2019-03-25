//
//  Comment.swift
//  BRAVOBET
//
//  Created by Александр on 28.09.17.
//  Copyright © 2017 Aleksandr Ilyin. All rights reserved.
//

import Foundation
import Parse

class Comment: PFObject, PFSubclassing {
  
    @NSManaged var nameAndCountry: String
    @NSManaged var comment: String
   
    
    class func parseClassName() -> String {
        
        return "Comments"
    }
    
}
