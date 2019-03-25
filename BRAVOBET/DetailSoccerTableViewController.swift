//
//  DetailSoccerTableViewController.swift
//  BRAVOBET
//
//  Created by Александр on 19.10.2017.
//  Copyright © 2017 Aleksandr Ilyin. All rights reserved.
//
import UIKit
import Parse


class DetailSoccerTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate  {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var detailSoccer: Soccer!
    var selectedSoccer = [Soccer]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
      
        
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        
       self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
       
       // self.navigationItem.rightBarButtonItem = barButton
      //  self.navigationItem.rightBarButtonItem?.tintColor = UIColor.universalColorYellow
        let yourBackImage = UIImage(named: "backItem")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        self.navigationController?.navigationItem.leftItemsSupplementBackButton = true
        self.navigationController?.navigationBar.tintColor = UIColor.universalColorYellow
        
        
        
        
        
        //title = detailSoccer.detailTitleS
        
        let nib: UINib = UINib(nibName: "CustomSoccerHeaderView", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "CustomSoccerHeaderView")
        tableView.tableFooterView = UIView(frame: .zero)
        
      
        //tableView.layer.masksToBounds = true
        tableView.estimatedRowHeight = 280
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName:"FootTableViewCell",bundle:nil), forCellReuseIdentifier: "cellSoc")
        self.view.addSubview(tableView)
        tableView.reloadData()
        loadMatchSoccer()
        
        
        
        //Headerc
        
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
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 350
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomSoccerHeaderView") as! CustomSoccerHeaderView
        
        header.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 350)
        
        header.clickBravisso = detailSoccer
        
        header.nameHeader.text = detailSoccer.matchS
        header.countBravo.text = ""
        
        
        // header.bravoBtn.addTarget(CustomSoccerHeaderView(), action: #selector(CustomSoccerHeaderView.likeBtn(_:)), for: UIControlEvents.touchUpInside)
        
        
        detailSoccer.imagePrS.getDataInBackground { (data, error) in
            header.imageHeader.image = error == nil ? UIImage(data: data!) : nil
        }
        
        
        return header
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let soccerCell = tableView.dequeueReusableCell(withIdentifier: "cellSoc") as! FootTableViewCell
        
        switch indexPath.row {
        case 0:
            soccerCell.titleLabel.text = "АНАЛИЗ К МАТЧУ"
            soccerCell.noteText.text = detailSoccer.textSoccer
        case 1:
            soccerCell.titleLabel.text = "ПРОГНОЗ"
            soccerCell.noteText.text = detailSoccer.detailPrognozS
        default:
            break
        }
        
       
        
        return soccerCell
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    
    
    func loadMatchSoccer() {
        
        let query = Soccer.query() as! PFQuery<Soccer>
        query.whereKey("matchS", equalTo: detailSoccer.matchS)
        
        query.findObjectsInBackground  { (objects, error) in
            if error == nil {
                
                self.selectedSoccer = objects!
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
                
            } else {
                print(error!)
            }
        }
    }
}










