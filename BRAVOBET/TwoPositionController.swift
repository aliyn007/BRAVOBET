//
//  TwoPositionController.swift
//  BRAVOBET
//
//  Created by Александр on 10/3/18.
//  Copyright © 2018 Александр. All rights reserved.
//

import UIKit
import Parse


class TwoPositionController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let user = PFUser.current()
        if (user?.isAuthenticated)! {
            let accountVC = InfoUserProfile()
            let accountRootVC = UINavigationController(rootViewController: accountVC)
             let appDelegate = UIApplication.shared.delegate as! AppDelegate
             appDelegate.window?.rootViewController = accountRootVC
            
        } else if (user?.isNew)! {
            let accountNowVC = nowViewController()
            let accountRootNowVC = UINavigationController(rootViewController: accountNowVC)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = accountRootNowVC
        }
        
    }

}
