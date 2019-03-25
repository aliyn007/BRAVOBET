//
//  InfoViewController.swift
//  BRAVOBET
//
//  Created by Александр on 23.08.17.
//  Copyright © 2017 Aleksandr Ilyin. All rights reserved.
//

import UIKit
import MessageUI
import Parse

class InfoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate {

    
    var saveClick: InfoMy!
    var userInformation = [InfoMy]()
    var userParent = [InfoMy]()
 
    private var barButtonItem: UIBarButtonItem?
     private var barButtonSend: UIBarButtonItem?
    @IBOutlet weak var tableView: UITableView!
    
    
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Обновление")
        
        refreshControl.addTarget(self, action:
            #selector(InfoViewController.updateRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.universalColorYellow
        
        return refreshControl
    }()
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = NSLocalizedString("Профиль Каппера", comment: "")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.universalColorYellow]
        
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 4.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 1.0
        self.navigationController?.navigationBar.layer.masksToBounds = false
        
        tableView.addSubview(self.refreshControl)
       
        self.navigationController?.navigationBar.tintColor = UIColor.universalColorYellow
       
      
        let barButtonSend = UIBarButtonItem(image: UIImage(named: "send"), style: .plain, target: self, action: #selector(sendMessage))
        self.navigationItem.rightBarButtonItem = barButtonSend
        self.barButtonSend = barButtonSend
        
        
        
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "likeGray"), style: .plain, target: self, action: #selector(leftNavigationLikeButton))
        self.navigationItem.leftBarButtonItem = barButtonItem
        self.barButtonItem = barButtonItem
        
        //title = detailSoccer.detailTitleS
        
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.estimatedRowHeight = 280
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
      
         loadMatchSoccer()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
    }
    
    
    
    
    
    
    func sendMessangeCount() {
        
        if barButtonSend?.image == UIImage(named: "send") {
            barButtonSend?.image = UIImage(named: "sendColor")
           
        } else {
            barButtonSend?.image = UIImage(named: "send")
        }
        
        let objectInfo = InfoMy(withoutDataWithClassName: "InfoMy", objectId: "PIorJ43dRq")
        objectInfo.incrementKey("countSend", byAmount: 1)
        
        
        objectInfo.saveInBackground {  (object, error) in
            if  error == nil {
                print("success")
                
                
            } else {
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
                
            }
        }
        
    }
   
    @objc func leftNavigationLikeButton() {
        
        if barButtonItem?.image == UIImage(named: "likeGray") {
            barButtonItem?.image = UIImage(named: "like2")
        } else {
            barButtonItem?.image = UIImage(named: "likeGray")
        }
        let objectInfo = InfoMy(withoutDataWithClassName: "InfoMy", objectId: "PIorJ43dRq")
       objectInfo.incrementKey("likeCount", byAmount: 1)
        
        
        objectInfo.saveInBackground {  (object, error) in
            if  error == nil {
                print("success")
                
                
            } else {
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
                
            }
        }
      
    }

    
    func showSendMailErrorAlert() {
        let alert = UIAlertController(title: "BRAVOBET", message: NSLocalizedString("Настройте вашу почту на телефоне", comment: ""), preferredStyle: .alert)
        
       // alert.addAction(UIAlertAction(title: "Да", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @objc func sendMessage() {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
            self.sendMessangeCount()
            
        } else {
            self.showSendMailErrorAlert()
            
        }
        
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["a.ilyin007@gmail.com"])
        mailComposerVC.setSubject(".....")
        mailComposerVC.setMessageBody("....", isHTML: false)
        
        return mailComposerVC
    }
    
  
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return userParent.count
            
        case 1:
            return userInformation.count
        default:
            return 0
        }
    
        
        
    }
    
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        switch  indexPath.section {
        case 0:
            
            let  titleCell = tableView.dequeueReusableCell(withIdentifier: "titleCell") as! HeaderMyCellTableViewCell
            titleCell.clappingCount.text = "\(userParent[indexPath.row].likeCount.roundedWithAbbreviations)"
            titleCell.sendingMail.text = "\(userParent[indexPath.row].countSend.roundedWithAbbreviations)"
            titleCell.userMyName.text = userParent[indexPath.row].name
            
            
            userInformation[indexPath.row].imageProfile.getDataInBackground {(data, error) in
                titleCell.imagePhoto.image = error == nil ? UIImage(data: data!) : nil
            }
            
            return titleCell
        case 1:
            let infoCell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as! InfoTableViewCell
            infoCell.titleProfile.text = "О ПРОЕКТЕ"
            infoCell.infogdevice.text = userInformation[indexPath.row].myinfo
            
            
            
            return infoCell
            
        default:
            break
        }
        return UITableViewCell()

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    @objc func updateRefresh(_ refreshControl: UIRefreshControl) {
        
      
    
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
    func loadMatchSoccer() {
        
        
        let qwery = InfoMy.query() as! PFQuery<InfoMy>
        
        qwery.findObjectsInBackground { (object, error) in
            if error == nil {

                self.userInformation = object!
                self.userParent = object!
             
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            } else {
                print(error!)
                
            }
        }
        
        
       
    }
    


}
