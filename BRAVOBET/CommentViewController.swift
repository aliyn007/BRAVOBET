//
//  CommentViewController.swift
//  BRAVOBET
//
//  Created by Александр on 29.09.17.
//  Copyright © 2017 Aleksandr Ilyin. All rights reserved.
//

import UIKit
import Parse

class CommentViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var commentos = [Comment]()
   
 
    
    @IBOutlet weak var tableView: UITableView!
    @objc var refresh: UIRefreshControl!
  
    @IBAction func pressedComment(_ sender: Any) {
        
        if let user = PFUser.current() {
            if user.isAuthenticated {
             let segue = RecallViewController()
                segue.usernameText.frame = segue.nameAndCounry.frame
                segue.usernameText.isHidden = true
                segue.usernameText.textColor = UIColor.white
           
                segue.nameAndCounry.isHidden = false
                segue.usernameText.text = ""
                view.addSubview(segue.usernameText)
                
           self.performSegue(withIdentifier: "showCom", sender: self)
           }
        
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 4.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 1.0
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.barTintColor = UIColor.newBlaColor
        
     
        let yourBackImage = UIImage(named: "backItem")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        self.navigationController?.navigationItem.leftItemsSupplementBackButton = true
        self.navigationController?.navigationBar.tintColor = UIColor.universalColorYellow
        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: NSLocalizedString("Обновить", comment: "Обновить"))
        
        refresh.tintColor = UIColor.yellow
        
        refresh.addTarget(self, action: #selector(refreshing), for: UIControl.Event.valueChanged)
        tableView.register(UINib(nibName:"CommentTableViewCell",bundle:nil), forCellReuseIdentifier: "Cell")
       
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.addSubview(refresh)
         tableView.reloadData()
        loadComment()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = NSLocalizedString("Отзывы", comment: "")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let image = UIImage(named: "smilesan")
    
        
        if commentos.count == 0 {
            tableView.setEmptyView(title: NSLocalizedString("На данный момент комментариев нет", comment: ""), message:NSLocalizedString("Ждём ваши комментарии", comment: ""), messageImage: image!)
        } else {
            tableView.restore()
        }
        // #warning Incomplete implementation, return the number of rows
        return commentos.count
    }
    
    @IBAction func unwindToBack(segue: UIStoryboardSegue) {}
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!CommentTableViewCell
        let newInt = (commentos.count - 1) - indexPath.row
        cell.comment.text = commentos[newInt].comment
        cell.nameAndCountry.text = commentos[newInt].nameAndCountry
        
        
        let df = DateFormatter()
         df.dateStyle = .long
        df.dateFormat = "dd.MM.yyyy"
        df.locale = Locale(identifier: "ru_UA")
        df.doesRelativeDateFormatting = true
        
        let timeNew = commentos[newInt].createdAt
        //cell.dataLabel.text = df.string(from: timeNew!)
        cell.dataLabel.text = timeNew?.getPastTime(for: timeNew!)
        
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
   
    
    @objc func refreshing() {
        loadComment()
        
        tableView.reloadData()
        refresh.endRefreshing()
        
        
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
        
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
    
    
    func loadComment() {
        
        let query = Comment.query() as! PFQuery<Comment>
        
        query.findObjectsInBackground  { (objects, error) in
            if error == nil {
                
               
                self.commentos = objects!
                self.tableView.reloadData()
             } else {
                print(error!)
            }
            }
    
    }
    
    
    
}

extension UITableView {
    
    func setEmptyView(title: String, message: String, messageImage: UIImage) {
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let messageImageView = UIImageView()
     
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        
        messageImageView.backgroundColor = .clear
        
        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageImageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = UIColor.universalColorYellow
        titleLabel.font = UIFont(name: "ChalkboardSE-Bold", size: 15)
        
        messageLabel.textColor = UIColor.white
        messageLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 14)
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageImageView)
        emptyView.addSubview(messageLabel)
        
        messageImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -50).isActive = true
        messageImageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        messageImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: messageImageView.bottomAnchor, constant: 30).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageImageView.image = messageImage
        messageImageView.tintColor = UIColor.liteD
        
        
        
        
    
        
        titleLabel.text = title
        titleLabel.numberOfLines = 2
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        UIView.animate(withDuration: 1, animations: {
            
            messageImageView.transform = CGAffineTransform(rotationAngle: .pi / 10)
        }, completion: { (finish) in
            UIView.animate(withDuration: 1.2, animations: {
                messageImageView.transform = CGAffineTransform(rotationAngle: -5 * (.pi / 60))
            }, completion: { (finishh) in
                UIView.animate(withDuration: 1, animations: {
                    messageImageView.transform = CGAffineTransform.identity
                })
            })
            
        })
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
}
    func restore() {
        
        self.backgroundView = nil
        //self.separatorStyle = .singleLine
        
    }
    
}
