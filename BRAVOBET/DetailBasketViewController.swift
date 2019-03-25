//
//  DetailBasketViewController.swift
//  BRAVOBET
//
//  Created by Александр on 04.10.17.
//  Copyright © 2017 Aleksandr Ilyin. All rights reserved.
//

import UIKit
import Parse

class DetailBasketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

  
    @IBOutlet weak var tableView: UITableView!
    
    
    
      var baskets : Basketball!
      var selectedBasketball = [Basketball]()
    
    
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
        
        
        
        let nib: UINib = UINib(nibName: "CustomHeaderBasket", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "CustomHeaderBasket")
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName:"BasketballTableViewCell",bundle:nil), forCellReuseIdentifier: "basketCell")
        self.view.addSubview(tableView)
          tableView.reloadData()
          loadMatchBasket()
        
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        let yourBackImage = UIImage(named: "backItem")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        self.navigationController?.navigationItem.leftItemsSupplementBackButton = true
        self.navigationController?.navigationBar.tintColor = UIColor.universalColorYellow
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
       
        
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
        
        return 350
    }
    
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerBasket = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeaderBasket") as! CustomHeaderBasket
        
        headerBasket.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 350)
        
        headerBasket.clickBasket = baskets
        
        headerBasket.titleBasket.text = baskets.matchB
        headerBasket.countLikeBasket.text = ""
        
        
        // header.bravoBtn.addTarget(CustomSoccerHeaderView(), action: #selector(CustomSoccerHeaderView.likeBtn(_:)), for: UIControlEvents.touchUpInside)
        
        
        baskets.imagePrB.getDataInBackground { (data, error) in
            headerBasket.imageBasket.image = error == nil ? UIImage(data: data!) : nil
        }
        
        
        return headerBasket
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let basketCell = tableView.dequeueReusableCell(withIdentifier: "basketCell", for: indexPath) as! BasketballTableViewCell
        
        switch indexPath.row {
        case 0:
            basketCell.title.text = "АНАЛИЗ К МАТЧУ"
            basketCell.titleText.text = baskets.detailTextB
        case 1:
            basketCell.title.text = "ПРОГНОЗ"
            basketCell.titleText.text = baskets.detailPrB
        default:
            break
        }
        
        
        return basketCell
    }
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    func loadMatchBasket() {
        
        let query = Basketball.query() as! PFQuery<Basketball>
        query.whereKey("matchB", equalTo: baskets.matchB)
        query.findObjectsInBackground  { (objects, error) in
            if error == nil {
                self.selectedBasketball = objects!
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
                
                
                
            } else {
                print(error!)
            }
            
        }
    }
    
}

        


    

        
        


    
 
