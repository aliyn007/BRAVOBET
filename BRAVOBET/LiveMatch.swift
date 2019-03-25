//
//  LiveMatch.swift
//  BRAVOBET
//
//  Created by Александр on 10/28/18.
//  Copyright © 2018 Aleksandr ILIN. All rights reserved.
//

import UIKit
import Parse

class LiveMatch: PFObject,PFSubclassing {
    
    
    @NSManaged var nameMatchLive: String
   
    @NSManaged var forecasts: String
    
    
    class func parseClassName() -> String {
        
        return "Live"
    }
    
}
