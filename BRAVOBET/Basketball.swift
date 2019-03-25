//
//  Basketball.swift
//  BRAVOBET
//
//  Created by Александр on 18.08.17.
//  Copyright © 2017 Aleksandr Ilyin. All rights reserved.
//

import Foundation
import Parse


class Basketball : PFObject,PFSubclassing {
    

    @NSManaged var matchB: String
    @NSManaged var imagePrB: PFFile
    @NSManaged var bravo: Int
    @NSManaged var sharecount: Int
    @NSManaged var basketviews: Int
    @NSManaged var booleanB: PFFile
    @NSManaged var resultB : PFFile
    @NSManaged var detailTextB : String
    @NSManaged var detailPrB: String
  
    @NSManaged var basketTitle : String
    
    
    class func parseClassName() -> String {
        
        return "Basketball"
    }
    
}
