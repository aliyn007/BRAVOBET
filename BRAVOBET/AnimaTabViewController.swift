//
//  AnimaTabViewController.swift
//  BRAVOBET
//
//  Created by Александр on 1/28/19.
//  Copyright © 2019 Aleksandr Ilin. All rights reserved.
//

import UIKit


extension UITableView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }
        
        return lastIndexPath == indexPath
    }
}
