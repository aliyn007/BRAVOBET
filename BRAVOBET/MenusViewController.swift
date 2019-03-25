//
//  MenusViewController.swift
//  BRAVOBET
//
//  Created by Александр on 10/25/18.
//  Copyright © 2018 Aleksandr ILIN. All rights reserved.
//

import UIKit

class MenusViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 270, height: 40))
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 270, height: 40))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "golos")
        imageView.image = image
        logoContainer.addSubview(imageView)
        self.navigationItem.titleView = logoContainer
        
        
        
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 4.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 1.0
        self.navigationController?.navigationBar.layer.masksToBounds = false
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
