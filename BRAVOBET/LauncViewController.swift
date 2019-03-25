//
//  LauncViewController.swift
//  BRAVOBET
//
//  Created by Александр on 23.05.2018.
//  Copyright © 2018 Aleksandr Ilyin. All rights reserved.
//

import UIKit
import Parse

class LauncViewController: UIViewController {
   
    
    @IBOutlet weak var progressBar: UIProgressView!
    var progressValue = 0.0
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateProgressValue), userInfo: nil, repeats: true)
 
              // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func updateProgressValue() {
       
        progressValue = progressValue + 0.3
        self.progressBar.setProgress(Float(progressValue), animated: true)
        self.progressBar.progress = Float(progressValue)
       
        if  progressValue >= 1 {
            
            timer.invalidate()
            
            
            // timer = nil
            let currentUser = PFUser.current()
            if  currentUser != nil  {
         
               self.menuController()
            
            } else  {
             
                self.presentController()
                
            }
            
        }
  
        
            }
    
    func menuController() {
        
        let MenuVC = self.storyboard?.instantiateViewController(withIdentifier: "TabViewController") as! TabBarViewController
        
        self.present(MenuVC, animated: true, completion: nil)
    }
    
    func presentController() {
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "NewController") as!LoginController
        
        self.present(VC, animated: false, completion: nil)
    }

    




func notLoggedIn() -> Bool {
    let user = PFUser.current()
    // here I assume that a user must be linked to Facebook
    return user == nil || !PFFacebookUtils.isLinked(with: user!)
}
 func loggedIn() -> Bool {
    return !notLoggedIn()
}

}
