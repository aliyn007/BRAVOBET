//
//  InfoUserProfile.swift
//  BRAVOBET
//
//  Created by Александр on 30.06.2018.
//  Copyright © 2018 Aleksandr Ilyin. All rights reserved.
//

import UIKit
import Parse
class InfoUserProfile: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    var dict : NSDictionary!
    var myUser = [PFUser.current()]
    let userId: PFUser? = nil
   
    
    @IBOutlet weak var tableView: UITableView!
 
    
    @IBAction func newTitleBarItem(_ sender: UIBarButtonItem) {
        

        
    }
    
    
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("Обновление", comment: ""))
        
        refreshControl.addTarget(self, action:
            #selector(InfoUserProfile.updateRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.universalColorYellow
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        let barButtonSend = UIBarButtonItem(image: UIImage(named: "exit"), style: .plain, target: self, action: #selector(outLogin))
        self.navigationItem.rightBarButtonItem = barButtonSend
        self.navigationItem.title = NSLocalizedString("Профиль", comment: "")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.universalColorYellow]
         tableView.addSubview(self.refreshControl)
         self.navigationController?.navigationBar.tintColor = UIColor.universalColorYellow
        self.view.setGradientBackground(colorOne: UIColor.Black11, colorTwo: UIColor.ColorBlack2)
        tableView.tableFooterView = UIView(frame: .zero)
        let nib: UINib = UINib(nibName: "UserHeaderView", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "UserHeaderView")
        tableView.estimatedRowHeight = 280
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
         tableView.reloadData()
        //loadUser()
        loadUserInfo()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController!.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
    }
    
    @objc func segueEdit() {
        self.performSegue(withIdentifier: "showUser", sender: self)
        
    }
    
    
    
    
    @objc func outLogin() {
        
         let alertMessage = UIAlertController(title: "BRAVOBET", message: NSLocalizedString("Вы собираетесь выйти или удалить аккаунт", comment: ""), preferredStyle: .alert)
        let exit = UIAlertAction(title: NSLocalizedString("Выйти", comment: ""), style: .default) { (action) in
            PFUser.logOut()
            self.segueLogIN()
        }
        let delete = UIAlertAction(title: NSLocalizedString("Удалить", comment: ""), style: .default) { (action) in
            PFUser.current()?.deleteInBackground(block: { (deleteSuccessful, error) -> Void in
                // User deleted, log out the user
                PFUser.logOut()
            })
            self.segueLogIN()
        }
        let cancel = UIAlertAction(title: NSLocalizedString("Отмена", comment: ""), style: .cancel, handler: { (action) in
        })
        alertMessage.addAction(exit)
        alertMessage.addAction(delete)
        alertMessage.addAction(cancel)
       self.present(alertMessage, animated: true, completion: nil)
    }
   
    func segueLogIN() {
        let logOut = storyboard?.instantiateViewController(withIdentifier: "NewController") as! LoginController
        self.present(logOut, animated: true, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 300
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "UserHeaderView") as! UserHeaderView
        
        header.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300)
        header.usname.text = PFUser.current()!.username
        if  header.fotoUser.image != nil {
            header.fotoUser.image = UIImage(named: "noFoto")
        } 
        
        let imagePro = PFUser.current()?.object(forKey: "profile_picture") as? PFFile
        imagePro?.getDataInBackground { (data, error) in
            header.fotoUser.image = error == nil ? UIImage(data: data!) : nil
          }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as! UserProfileInfoTableViewCell
        
        
        
        switch indexPath.row {
        case 0:
            cell.lineUser.text = PFUser.current()!.object(forKey: "email") as? String
            cell.lineLogo.image = UIImage(named: "mail1")
            
        case 1:
            cell.lineUser.text = PFUser.current()!.object(forKey: "country") as? String
             cell.lineLogo.image = UIImage(named: "flags")
        default:
            break
        }
        
        
        return cell
    }

    
    @objc func updateRefresh(_ refreshControl: UIRefreshControl) {
    
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
