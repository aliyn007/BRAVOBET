//
//  File.swift
//  BRAVOBET
//
//  Created by Александр on 22.06.17.
//  Copyright © 2017 Aleksandr Ilyin. All rights reserved.
//




import UIKit
import Parse


class RegistarationController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet{
            activityIndicator.isHidden = true
            activityIndicator.style = .white
        }
    }
    
   
    
    @IBOutlet weak var registrationButtonOutlet: UIButton!{
        didSet{
         registrationButtonOutlet.setTitleColor(.black, for: .normal)
         registrationButtonOutlet.layer.cornerRadius = 20
        }
    }
    
    
    @IBOutlet weak var emailTF: UITextField! {
        didSet{
            emailTF.layer.cornerRadius = 20
            emailTF.textColor = .white
            emailTF.returnKeyType = .next
        }
    }
    
    @IBOutlet weak var usernameTF: UITextField! {
        didSet{
            usernameTF.layer.cornerRadius = 20
            usernameTF.textColor = .white
            usernameTF.returnKeyType = .next
        }
    }
    
    @IBOutlet weak var passwordTF: UITextField! {
        didSet{
            
            passwordTF.textColor = .white
            passwordTF.returnKeyType = .done
            passwordTF.layer.cornerRadius = 20
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func alert(message: NSString, title: NSString) {
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
    
            animateViewMoving(up: true, moveValue: 100)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
  
            animateViewMoving(up: false, moveValue: 100)
        
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        
        UIView.beginAnimations("animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


    @objc func didTapView() {
        self.view.endEditing(true)
    }
    
    @IBAction func registrationActionButton(_ sender: Any) {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            
            self.view.endEditing(true)
            let user = PFUser()
            user.email = emailTF.text
            user.username = usernameTF.text
            user.password = passwordTF.text
            user["country"] = countryTF.text
            if user.email == "" || user.password == "" || user.username == "" {
                let messageTitle = NSLocalizedString("Заполните все поля", comment: "")
                let title = NSLocalizedString("Ошибка", comment: "")
                self.alert(message: messageTitle  as NSString, title: title as NSString)
            } else {
                user.signUpInBackground { (suc, error)  in
                    if suc  {
                        Alert.show(textTitle:NSLocalizedString("BRAVOBET", comment: ""), text: NSLocalizedString("Вы успешно зарегистрированы", comment: ""), view: self)
                        self.activityIndicator.isHidden = true
                        self.activityIndicator.stopAnimating()
                    }else {
                        if let descrip = error?.localizedDescription{
                            self.displayErrorMessage(message: descrip)
                            
                            self.activityIndicator.isHidden = true
                            self.activityIndicator.stopAnimating()
                        }
                    }
                }
            }
        }
    
    
    
    @IBOutlet weak var countryTF: UITextField! {
        didSet{
            countryTF.textColor = UIColor.white
            countryTF.returnKeyType = .done
            countryTF.layer.cornerRadius = 20
        }
        
    }
       @IBAction func close(_ sender: Any) {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
    
    }
    
    
    @IBOutlet weak var outletCls: UIButton!
    func configureButton() {
        outletCls.layer.cornerRadius = 0.5 * outletCls.bounds.size.width
        outletCls.clipsToBounds = true
    }
    

}
 

