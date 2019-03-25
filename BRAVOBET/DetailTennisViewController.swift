//
//  DetailTennisViewController.swift
//  BRAVOBET
//
//  Created by Александр on 04.10.17.
//  Copyright © 2017 Aleksandr Ilyin. All rights reserved.
//

import UIKit
import Parse

class DetailTennisViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    
    
    var selectedTennis = [Tennis]()
    var tenises: Tennis!
   
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController!.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        
        let nib: UINib = UINib(nibName: "HeaderTennisCustomTableViewCell", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "HeaderTennisCustomTableViewCell")
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName:"TennisTableViewCell",bundle:nil), forCellReuseIdentifier: "tenCell")
        self.view.addSubview(tableView)
        tableView.reloadData()
        loadMatchTennis()
        
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        let yourBackImage = UIImage(named: "backItem")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        self.navigationController?.navigationItem.leftItemsSupplementBackButton = true
        self.navigationController?.navigationBar.tintColor = UIColor.universalColorYellow
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        
    
       
        
        
      /**  if let object = tenises {
            self.textTennis.text = object["textTen"] as? String
            self.progTennis.text = object["progTen"] as? String
            self.titleTennis.text = object["titleTen"] as? String
            let imageFile = object["tenImage"] as? PFFile
            imageFile?.getDataInBackground() { (data:Data?, error:Error?)->Void in
                if error == nil {
                    if let imageData = data {
                        self.imageTennis.image = UIImage(data: imageData)
                        
                        
                        
                        
                    }
                    
                }
        }
        
    */
        
        // Do any additional setup after loading the view.
    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 350
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerTennis = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderTennisCustomTableViewCell") as!HeaderTennisCustomTableViewCell
        
        headerTennis.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 350)
        headerTennis.clickTennis = tenises
        headerTennis.titleTennis.text = tenises.matchT
        headerTennis.bravoTennisCount.text = ""
        
        // header.bravoBtn.addTarget(CustomSoccerHeaderView(), action: #selector(CustomSoccerHeaderView.likeBtn(_:)), for: UIControlEvents.touchUpInside)
        
        tenises.imagePrT.getDataInBackground { (data, error) in
            headerTennis.imageTennis.image = error == nil ? UIImage(data: data!) : nil
        }
        
        return headerTennis
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tennisCell = tableView.dequeueReusableCell(withIdentifier: "tenCell", for: indexPath) as! TennisTableViewCell
        
        switch indexPath.row {
        case 0:
            tennisCell.titleTen.text = "АНАЛИЗ К МАТЧУ"
            tennisCell.textTen.text = tenises.textTen
        case 1:
            tennisCell.titleTen.text = "ПРОГНОЗ"
            tennisCell.textTen.text = tenises.progTen
        default:
            break
        }
        
        
        return tennisCell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func loadMatchTennis() {
        
        let query = Tennis.query() as! PFQuery<Tennis>
        query.whereKey("matchT", equalTo: tenises.matchT)
        query.findObjectsInBackground  { (objects, error) in
            if error == nil {
                self.selectedTennis = objects!
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
                
            } else {
                print(error!)
            }
            
        }
        
    }

}

