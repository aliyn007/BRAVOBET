//
//  UserProfile.swift
//  BRAVOBET
//
//  Created by Александр on 15.06.2018.
//  Copyright © 2018 Aleksandr Ilyin. All rights reserved.
//

import UIKit
import Parse

class UserProfile: UITableViewController,UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
   
    @IBOutlet weak var outletAdd: UIButton!{
        didSet{
           imageUserProfile.addSubview(outletAdd)
           imageUserProfile.isUserInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!{
        didSet{
            activityIndicator.isHidden = true
            activityIndicator.style = .white
        }
    }
    var myUser = [PFUser.current()]
    
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var imageUserProfile: UIImageView! {
        didSet {
            
            imageUserProfile.layer.cornerRadius = imageUserProfile.frame.size.width/2
            imageUserProfile.clipsToBounds = true
            imageUserProfile.layer.borderColor = UIColor.universalColorYellow.cgColor
            imageUserProfile.layer.borderWidth = 1
            
            
        }
    }
    
    
    @IBOutlet weak var username: UITextField!{
        didSet {
            username.tag = 1
            username.becomeFirstResponder()
            username.delegate = self
            username.layer.cornerRadius = 20
            username.textColor = .white
            username.returnKeyType = .next
        }
    }
    @IBAction func addPhoto(_ sender: Any) {
        
        
        let photoSourceRequestController = UIAlertController(title: "", message:NSLocalizedString("Выберите источник фотографии", comment: ""), preferredStyle: .actionSheet)
        
 
        
        let photoLibraryAction = UIAlertAction(title: NSLocalizedString("Фотогаллерея", comment: ""), style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                
                self.present(imagePicker, animated: true, completion: nil)
            }
        })
        
      
        photoSourceRequestController.addAction(photoLibraryAction)
        
        present(photoSourceRequestController, animated: true, completion: nil)
        
        
        
    }
    
    
    
    
    @IBOutlet weak var countryTextField: UITextField!{
        didSet{
            countryTextField.tag = 2
            countryTextField.delegate = self
            countryTextField.layer.cornerRadius = 20
            countryTextField.textColor = .white
            countryTextField.returnKeyType = .next
            
        }
    }
    
    @IBOutlet weak var emailTextField: UITextField!{
        didSet {
            emailTextField.tag = 3
            emailTextField.delegate = self
            emailTextField.layer.cornerRadius = 20
            emailTextField.textColor = .white
            emailTextField.returnKeyType = .next
            
        }
    }
    
    @IBOutlet weak var passwordTextField: UITextField!{
        didSet{
            passwordTextField.tag = 4
            passwordTextField.delegate = self
            passwordTextField.layer.cornerRadius = 20
            passwordTextField.textColor = .white
            passwordTextField.returnKeyType = .done
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = NSLocalizedString("Редактирование профиля", comment: "")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.universalColorYellow]
        let yourBackImage = UIImage(named: "backItem")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        self.navigationController?.navigationItem.leftItemsSupplementBackButton = true
        let backButton = UIBarButtonItem()
         self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.universalColorYellow]
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = UIColor.universalColorYellow
        //navigationController?.navigationBar.backItem?.title = "Назад"
        let buttonSave = UIBarButtonItem(image: UIImage(named: "upload"), style: .plain, target: self, action: #selector(saveUIUser))
        navigationItem.rightBarButtonItem = buttonSave
    
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGestureRecognizer)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        self.loadUserInfo()
        
        let userName = PFUser.current()!.object(forKey: "username") as! String
    
       let country = PFUser.current()!.object(forKey: "country") as? String
                
        
        let email = PFUser.current()!.object(forKey: "email") as!String
       // let password = PFUser.current()?.object(forKey: "password") as! String
        username.text = userName
        nameUser.text = userName
        countryTextField.text = country
        
        emailTextField.text = email
       // passwordTextField.text = password
        if  imageUserProfile.image != nil {
            imageUserProfile.image = UIImage(named: "noFoto")
        }
            
        let imagePro = PFUser.current()?.object(forKey: "profile_picture") as? PFFile
        imagePro?.getDataInBackground { (data, error) in
              self.imageUserProfile.image = error == nil ? UIImage(data: data!) : nil
            }
            
    
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController!.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
    }
    @objc func didTapView() {
        self.view.endEditing(true)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            
        }
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
   func imagePickerController(_ picker: UIImagePickerController,
                                       didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         let selectedImage = info[.originalImage] as? UIImage
            imageUserProfile.image = selectedImage
            imageUserProfile.contentMode = .scaleAspectFill
            imageUserProfile.clipsToBounds = true
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func alert(message: NSString, title: NSString) {
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    @objc func saveUIUser() {
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        self.view.endEditing(true)
        let user = PFUser.current()!
        user.email = emailTextField.text
        user.username = username.text
        user.password = passwordTextField.text
        user["country"] = countryTextField.text
       
        
        if let imageUsers = imageUserProfile.image {
            let imageData = imageUsers.jpegData(compressionQuality: 0.75)
            let fileName = username.text! + ".png"
            let imageFile = PFFile(name:fileName, data:imageData!)
            user["profile_picture"] = imageFile
            
        }
        
        
        if user.email == "" || user.password == "" || user.username == "" {
            let messageTitle = NSLocalizedString("Заполните все поля", comment: "")
            let title = NSLocalizedString("Ошибка", comment: "")
            self.alert(message: messageTitle  as NSString, title: title as NSString)
        } else {
            user.saveInBackground(block:{ (suc, error)  in
                if suc  {
                    let messageTitle = NSLocalizedString("BRAVOBET", comment: "")
                    let title = NSLocalizedString("Вы успешно обновили данные", comment: "")
                    self.alert(message: title  as NSString, title: messageTitle as NSString)
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                   
                }else {
                    if let descrip = error?.localizedDescription{
                      //  self.displayErrorMessage(message: descrip)
                        print("\(descrip)")
                         self.activityIndicator.isHidden = true
                       
                        self.activityIndicator.stopAnimating()
                    }
                }
            })
        }
        
    }
    
    func undwinProfile() {
        
        let MenuVC = self.storyboard?.instantiateViewController(withIdentifier: "InfoUserProfile") as! InfoUserProfile
        
        self.present(MenuVC, animated: true, completion: nil)
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
    
    func loadUserInfo() {
        
        let userInformation = PFQuery(className: "User")
        
        userInformation.findObjectsInBackground(block: { (objectUser, error) in
            
            if (objectUser != nil) {
                
                self.myUser = objectUser! as! [PFUser]
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                    
                    
                })
            }
            
        })
        }
        
    
    
    
}

