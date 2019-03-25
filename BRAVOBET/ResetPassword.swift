//
//  ResetPassword.swift
//  BRAVOBET
//
//  Created by Александр on 27.06.17.
//  Copyright © 2017 Aleksandr Ilyin. All rights reserved.
//

import Foundation
import UIKit
import Parse

class ResetPassword : UIViewController, UITextFieldDelegate {
    
    
    
    
    
    @IBOutlet weak var emailTF: UITextField! {
        didSet{
            emailTF.layer.cornerRadius = 20
            emailTF.textColor = .white
            emailTF.returnKeyType = .done
        }
    }
    
    
    @IBOutlet weak var resetBtn: UIButton!{
        didSet{
            resetBtn.layer.cornerRadius = 20
        
            
        }
    }
    @IBOutlet weak var closeBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        
    }
    func configureButton()
    {
        closeBtn.layer.cornerRadius = 0.5 * closeBtn.bounds.size.width
        
        
        closeBtn.clipsToBounds = true
    }
    
    
    @IBAction func closeBtn(_ sender: Any) {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
   
    @IBAction func resetBtn(_ sender: UIButton) {
        
        let userEmail = self.emailTF.text
        PFUser.requestPasswordResetForEmail ( inBackground: userEmail!)
        
        let alert = UIAlertController (title: NSLocalizedString("Восстановление пароля", comment:""), message: NSLocalizedString("На указанный адрес прийдет сообщение c дальнейшими указаниями", comment: "") + userEmail! + ".", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
    

