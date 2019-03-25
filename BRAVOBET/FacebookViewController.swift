//
//  FacebookViewController.swift
//  BRAVOBET
//
//  Created by Александр on 18.06.2018.
//  Copyright © 2018 Aleksandr Ilyin. All rights reserved.
//

import UIKit
import Parse


class FacebookViewController: UIViewController {

  var dict : NSDictionary!

    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var usernameFB: UILabel!
    
    
    @IBOutlet weak var facebookOutlet: UIButton!{
        didSet {
            
           facebookOutlet.layer.cornerRadius = 20
            // singInFacebookButtonOutlet.layer.masksToBounds = true
            facebookOutlet.layer.shadowColor = UIColor.black.cgColor
            facebookOutlet.layer.shadowOffset = CGSize(width: 3, height: 5)
            facebookOutlet.layer.shadowRadius = 5
            facebookOutlet.layer.shadowOpacity = 4.0
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    

    @IBAction func faceBookLogIN(_ sender: Any) {
     
        self.menuController()
       saveUserInfo()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 170, height: 40))
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 170, height: 40))
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
      self.navigationController?.navigationBar.barTintColor = UIColor.newBlaColor
 
      loadProfile()
      
        }
    
    
    func getFacebookUserInfo() {
        if(FBSDKAccessToken.current() != nil)
        {
            //print permissions, such as public_profile
            print(FBSDKAccessToken.current().permissions)
            let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id, name, email"])
            let connection = FBSDKGraphRequestConnection()
            
            connection.add(graphRequest, completionHandler: { (connection, result, error) -> Void in
                
                let data = result as! [String : AnyObject]
                
                let name: String = (data["name"] as? String)!
                
                let FBid = data["id"] as? String
                
                let user = PFUser.current()
                
                user!.setObject(name, forKey: "username")
                user!.setObject(FBid!, forKey: "email")
            })
            connection.start()
        }
    }
    
    
    func saveUserInfo() {
        if (FBSDKAccessToken.current() != nil) {
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id, email, name, picture.width(480).height(480)"])
        graphRequest?.start(completionHandler: { (connection, result, error) in
            if error != nil {
                print("Error",error!.localizedDescription)
            }
            else{
                print(result!)
                
                let field = result as? [String:Any]
           
                let username = field!["name"] as? String
             
                let email = field!["email"] as? String
                let imageURL = ((field!["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String
             
                    let url = URL(string: imageURL!)
                    let data = NSData(contentsOf: url!)
                    let image = UIImage(data: data! as Data)
                let fileName = username! + ".png"
                let avatar = PFFile(name: fileName, data: image!.pngData()!)
                   // self.provideImageData.image = image
                  let user = PFUser.current()
                user!.setObject(username!, forKey: "username")
                user!.setObject(email!, forKey: "email")
                user!.setObject(avatar!, forKey: "profile_picture")
                user!.saveInBackground()
                    
                
            }
        })
        
        }
        
    }
  
    
    
    
    func loadProfile() {
        if(FBSDKAccessToken.current() != nil) {
            FBSDKGraphRequest(graphPath:"me", parameters: ["fields":"id, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as? NSDictionary
                    print(self.dict)
                    
                    let userId: String = self.dict.object(forKey: "id") as! String
                    NSLog(((self.dict.object(forKey: "picture") as AnyObject).object(forKey: "data") as AnyObject).object(forKey:"url") as! String)
                    let imgURLString = "http://graph.facebook.com/" + userId + "/picture?type=large&redirect=true&width=500&height=500" //replace 500 with your desired size
                    let first =  (self.dict.object(forKey: "first_name") as! String)
                    let last =  (self.dict.object(forKey: "last_name") as! String)
                    //  let email: String = self.dict.object(forKey: "email") as! String
                    
                    self.usernameFB.text = "\(first)   \(last)"
                    let imgURL = NSURL(string: imgURLString)
                    let imageData = NSData(contentsOf: imgURL! as URL)
                    self.userPicture.image = UIImage(data: imageData! as Data)
                    
                    
                }
            })
        }
        
    }
    
    
    
    
    
    
    func menuController() {
        
        let MenuVC = self.storyboard?.instantiateViewController(withIdentifier: "TabViewController") as! TabBarViewController
        
        self.present(MenuVC, animated: true, completion: nil)
    }
    
    @IBAction func facebookSignOut(_ sender: Any) {
        
        PFUser.logOutInBackground() { (error)-> Void in
            
            
        }
    }
    

}
