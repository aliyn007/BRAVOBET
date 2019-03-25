//
//  Tennis.swift
//  BRAVOBET
//
//  Created by Александр on 18.08.17.
//  Copyright © 2017 Aleksandr Ilyin. All rights reserved.
//

import Foundation
import Parse



class Tennis : PFObject,PFSubclassing {
    
    
    @NSManaged var matchT: String
    @NSManaged var imagePrT: PFFile
    @NSManaged var shareCount: Int
    @NSManaged var bravoTen:Int
    @NSManaged var viewsTen: Int
    @NSManaged var resultT : PFFile
    @NSManaged var booleanT: PFFile
    @NSManaged var textTen : String
    @NSManaged var progTen: String
    @NSManaged var titleTen: String

    
    class func parseClassName() -> String {
        
        return "Tennis"
    }
    
}

