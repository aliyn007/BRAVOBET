//
//  InfoMy.swift
//  BRAVOBET
//
//  Created by Александр on 05.09.2018.
//  Copyright © 2018 Aleksandr Ilyin. All rights reserved.
//

import UIKit
import Parse

class InfoMy: PFObject,PFSubclassing {
    
    @NSManaged var myinfo: String
    @NSManaged var likeCount: Int
    @NSManaged var name: String
     @NSManaged var countSend: Int
    @NSManaged var imageProfile: PFFile
    
    class func parseClassName() -> String {
        
        return "InfoMy"
    }
}
