//
//  RecallViewController.swift
//  BRAVOBET
//
//  Created by Александр on 24.08.17.
//  Copyright © 2017 Aleksandr Ilyin. All rights reserved.
//

import UIKit
import Parse

class RecallViewController: UIViewController,UITextViewDelegate,UITextFieldDelegate {
    @IBOutlet weak var writeTextLabel: UILabel!{
        didSet{
            writeTextLabel.text = NSLocalizedString("Напишите свой отзыв", comment: "")
        }
    }
    
    @IBOutlet weak var nameAndCounry: UITextField! {
        didSet {
            nameAndCounry.layer.cornerRadius = 20
            
            
    
        }
    }
    
    @IBOutlet weak var comment: UITextView! {
        didSet {
            comment.layer.cornerRadius = 10
        }
    }
    
   let usernameText = UILabel()
    
    @IBOutlet weak var sizeButton: UIButton! {
        didSet {
            
            sizeButton.layer.cornerRadius = 20
        }
    }
    

    
    @IBOutlet weak var whatIsYOuName: UILabel!{
        didSet {
            whatIsYOuName.text = NSLocalizedString("Укажите свое имя и город", comment: "")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = NSLocalizedString("Написать отзыв", comment: "")
         comment.delegate = self
         nameAndCounry.delegate = self
         nameAndCounry.text = PFUser.current()?.username
         comment.text = ""
        // Do any additional setup after loading the view.
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
      //  imageView.contentMode = .scaleAspectFit
        
     //   let image = UIImage(named: "logosOne")
     //   imageView.image = image
        
      //  navigationItem.titleView = imageView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        nameAndCounry.resignFirstResponder()
        comment.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameAndCounry.resignFirstResponder()
        comment.resignFirstResponder()
    }
    
    
    func alert(message: NSString, title: NSString) {
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func saveComment(_ sender: Any) {
        
        let object = Comment()
   
        object.nameAndCountry = nameAndCounry.text!
        object.comment = comment.text!
            
        if object.nameAndCountry == "" || object.comment == ""  {
            let messageTitle = NSLocalizedString("Заполните все поля", comment: "")
            let title = NSLocalizedString("Ошибка", comment: "")
            self.alert(message: messageTitle  as NSString, title: title as NSString)
        } else {

        object.saveInBackground { (succes, error) in
            if error == nil {
                if succes {
                    self.performSegue(withIdentifier: "unwindToBack", sender: self)
                //NotificationCenter.default.post(name:Notification.Name(rawValue:"update"),object:nil)
                  
                }
            }
            
        }
        }
        
    }

    
}
