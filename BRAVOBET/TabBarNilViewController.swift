//
//  TabBarNilViewController.swift
//  BRAVOBET
//
//  Created by Александр on 10/3/18.
//  Copyright © 2018 Александр. All rights reserved.
//

import UIKit

class TabBarNilViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = UIColor.universalColorYellow
        tabBar.addShadow(ofColor: UIColor.black, radius: 4, offset: CGSize(width: 0.0, height: 2.0), opacity: 1.0)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
