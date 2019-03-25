//
//  ViewController.swift
//  BRAVOBET
//
//  Created by Александр on 21.06.17.
//  Copyright © 2017 Aleksandr Ilyin. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import FBSDKLoginKit



class LoginController:UIViewController, UITextFieldDelegate {
    @IBOutlet weak var passTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    var keyboardHeight: CGFloat = 0
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet{
            activityIndicator.isHidden = true
            activityIndicator.style = .white
        }
    }
    
    @IBOutlet weak var singUpView: UIView! {
        didSet{
            singUpView.backgroundColor = UIColor.clear
            
        }
    }
    
      var dict : NSDictionary!
   
    @IBOutlet weak var singInButtonOutlet: UIButton! {
        didSet{
            singInButtonOutlet.setTitleColor(.black, for: .normal)
            //singInButtonOutlet.backgroundColor = UIColor(red:1.00, green:0.52, blue:0.16, alpha:1.00)
            singInButtonOutlet.layer.cornerRadius = 20
            singInButtonOutlet.layer.shadowColor = UIColor.black.cgColor
            singInButtonOutlet.layer.shadowOffset = CGSize(width: 5, height: 5)
            singInButtonOutlet.layer.shadowRadius = 5
            singInButtonOutlet.layer.shadowOpacity = 1.0
            
        }
    }
    
    @IBOutlet weak var singInFacebookButtonOutlet: UIButton! {
        didSet{
            singInFacebookButtonOutlet.setTitleColor(.white, for: .normal)
          
           singInFacebookButtonOutlet.layer.cornerRadius = 20
           // singInFacebookButtonOutlet.layer.masksToBounds = true
           singInFacebookButtonOutlet.layer.shadowColor = UIColor.black.cgColor
            singInFacebookButtonOutlet.layer.shadowOffset = CGSize(width: 5, height: 5)
            singInFacebookButtonOutlet.layer.shadowRadius = 5
            singInFacebookButtonOutlet.layer.shadowOpacity = 1.0
            
        }
    }
    
  
    
    
   
    @IBOutlet weak var emailTF: UITextField! {
        didSet{
            emailTF.textColor = .white
            emailTF.layer.cornerRadius = 20
            emailTF.returnKeyType = .next
        }
    }
    
    @IBOutlet weak var passwordTF: UITextField! {
        didSet{
            passwordTF.isSecureTextEntry = true
            passwordTF.textColor = .white
            passwordTF.layer.cornerRadius = 20
            passwordTF.returnKeyType = .done
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
             
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didTapView() {
        self.view.endEditing(true)
    }
    
    
 
    func requestFacebook() {
        
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email, name, id"])
        let connection = FBSDKGraphRequestConnection()
        connection.add(graphRequest, completionHandler: { (connection, result, error) in
            if error != nil {
                print(error?.localizedDescription ?? String())
            } else {
                if let userDetails = result as? [String: String]{
                    print(userDetails)
                    let userName: String = userDetails["name"]!
                    let userId: String = userDetails["id"]!
                    let userEmail: String = userDetails["email"]!
                    let mySave: PFUser = PFUser.current()!
                    mySave.setObject(userName, forKey: "username")
                    mySave.setObject(userId, forKey: "objectId")
                    mySave.setObject(userEmail, forKey: "email")
                    let profileUserFoto = "https://graph.facebook.com/" + userId + "/picture?type=large"
                    let userFotoUrl = NSURL(string: profileUserFoto)
                    let dataUserFoto = NSData(contentsOf: userFotoUrl! as URL)
                    
                    let profileFileObject = PFFile(data:dataUserFoto! as Data)
                    mySave.setObject(profileFileObject!, forKey: "profile_picture")
                    mySave.saveInBackground(block: { (success, error) -> Void in
                        
                        if(success)
                        {
                            print("User details are now updated")
                        }
                        
                    })
                    
                }
            }
            connection?.start()
        })
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailTF {
            emailTF.becomeFirstResponder()
        }
        
        if textField == passwordTF {
            self.view.endEditing(true)
        }
        
        return true
    }
    
    func alert(message: NSString, title: NSString) {
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func facebookSignIn(_ sender: UIButton) {
        
      logInFacebook()
    }
    
        
    
    

    
    func logInFacebook() {
        PFFacebookUtils.logInInBackground(withReadPermissions: ["public_profile","email"], block: { (user, error) -> Void in
            if user != nil {
                //Display an alert message
                self.requestFacebook()
                let myAlert = UIAlertController(title:NSLocalizedString("BRAVOBET", comment: "BRAVOBET"), message:NSLocalizedString("Вы успешно зарегистрированы", comment: ""), preferredStyle: UIAlertController.Style.alert);
                
                let okAction =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                
                myAlert.addAction(okAction);
                self.present(myAlert, animated:true, completion:nil);
            }
            
            print("Current user token=\(String(describing: FBSDKAccessToken.current().tokenString))")
            
            print("Current user id \(String(describing: FBSDKAccessToken.current()))")
            
            if(FBSDKAccessToken.current() != nil) {
                let facebookPage = self.storyboard?.instantiateViewController(withIdentifier: "FacebookProfile") as! FacebookViewController
                
                let facebookPageNav = UINavigationController(rootViewController: facebookPage)
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                appDelegate.window?.rootViewController = facebookPageNav
                
            } 
            
        })
    }
    
    @IBAction func goToNotSign(_ sender: Any) {
        let TabLiteVC = self.storyboard?.instantiateViewController(withIdentifier: "tabBarNilAccount") as!TabBarNilViewController
        
        self.present(TabLiteVC, animated: true, completion: nil)
    }
   
    
    func displayErrorMessage(message:String) {
        let alertView = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
        }
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        self.present(alertView, animated: true, completion:nil)
       
        
    }

    @IBAction func signIn(_ sender: Any) {
        let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 150, height: 150)) as UIActivityIndicatorView
        if emailTextField.text == "" || passTextField.text == "" {
            let messageTitle = NSLocalizedString("Заполните все поля", comment: "")
            let title = NSLocalizedString("Ошибка", comment: "")
            self.alert(message: messageTitle  as NSString, title: title as NSString)
        } else {
            
            PFUser.logInWithUsername(inBackground:emailTextField.text!, password: passTextField.text!) { (user, error) -> Void in
                spinner.startAnimating()
                
                if  user != nil {
                    // if user!["emailVerified"] as! Bool == true {
                    // UserDefaults.standard.set(true, forKey: "ViewController")
                    self.loadMenuScreen()
                    self.alert(message:NSLocalizedString("Вы успешно зашли", comment: "") as NSString, title: NSLocalizedString("BRAVOBET", comment: "") as NSString)
                    spinner.stopAnimating()
                    
                    // }
                } else {
                    if let descrip = error?.localizedDescription{
                        self.displayErrorMessage(message: (descrip))
                        //self.loadMenuScreen()
                    }
                }
            }
        }
        
}
    
    
    
    
    
    func loadMenuScreen(){
        
        let MenuVC = self.storyboard?.instantiateViewController(withIdentifier: "TabViewController") as! TabBarViewController
        
        self.present(MenuVC, animated: true, completion: nil)
        
    }
    
    
}
