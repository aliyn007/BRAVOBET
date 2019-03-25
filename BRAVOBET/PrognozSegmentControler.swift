//
//  PrognozSegmentControler.swift
//  BRAVOBET
//
//  Created by Александр on 30.06.17.
//  Copyright © 2017 Aleksandr Ilyin. All rights reserved.
//


import UIKit
import Parse
import UserNotifications


class PrognozSegmentViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
        var soccerString = [Soccer]()
        var basketString = [Basketball]()
        var tennisString = [Tennis]()
   
    
    @objc var refresh : UIRefreshControl!
    
    typealias Animation = (UITableViewCell, IndexPath, UITableView) -> Void
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBAction func btnSegment(_ sender: Any) {
        
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
        })
       
        
    }
   
    final class Animator {
        private var hasAnimatedAllCells = false
        private let animation: Animation
        
        init(animation: @escaping Animation) {
            self.animation = animation
        }
        
        func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
            guard !hasAnimatedAllCells else {
                return
            }
            
            animation(cell, indexPath, tableView)
            
            hasAnimatedAllCells = tableView.isLastVisibleCell(at: indexPath)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0{
            changeTabBar(hidden: true, animated: true)
        }
        else{
            changeTabBar(hidden: false, animated: true)
        }
    }
    func changeTabBar(hidden:Bool, animated: Bool){
        guard let tabBar = self.tabBarController?.tabBar else { return; }
        if tabBar.isHidden == hidden{ return }
        let frame = tabBar.frame
        let offset = hidden ? frame.size.height : -frame.size.height
        let duration:TimeInterval = (animated ? 0.5 : 0.0)
        tabBar.isHidden = false
        
        UIView.animate(withDuration: duration, animations: {
            tabBar.frame = frame.offsetBy(dx: 0, dy: offset)
        }, completion: { (true) in
            tabBar.isHidden = hidden
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        //self.navigationController!.view.backgroundColor = UIColor.clear
       // self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 170, height: 40))
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 170, height: 40))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "golos")
        imageView.image = image
        logoContainer.addSubview(imageView)
        self.navigationItem.titleView = logoContainer
        
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 4.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 1.0
        self.navigationController?.navigationBar.layer.masksToBounds = false
        
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "vock"), style: .plain, target: self, action: #selector(notice))
        self.navigationItem.rightBarButtonItem = barButtonItem
        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: NSLocalizedString("Обновить", comment: ""))
        
        refresh.tintColor = UIColor.white
        refresh.addTarget(self, action:#selector(obnova), for: UIControl.Event.valueChanged)
        
        tableView.addSubview(refresh)
        setupSeg()
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.estimatedRowHeight = 88
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(UINib(nibName:"TableViewCell",bundle:nil), forCellReuseIdentifier: "sportCell")
       
         self.navigationController?.navigationBar.tintColor = UIColor.universalColorYellow
        loadObjects1()
        loadObjects2()
        loadObjects3()
        let currentUser = PFUser.current()
        
        if currentUser != nil {
            self.navigationItem.leftBarButtonItem = nil
        } else  {
            let barButtonItem = UIBarButtonItem(image: UIImage(named: "profileadd"), style: .plain, target: self, action: #selector(presentController))
            self.navigationItem.leftBarButtonItem = barButtonItem
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
  
        
    }
    @objc func notice() {
        let alerNotice = UIAlertController(title: NSLocalizedString("Пользовательское соглашение", comment: ""), message: NSLocalizedString("Компания BRAVOBET  не устраивает и не проводит азартные игры. Вы получаете услугу в виде прогноза на спортивное событие от аналитика в области спорта.Я не несу ответственности за исход события.Информация носит ознокомительный характер.", comment: ""), preferredStyle: .alert)
        
        
        let action2 = UIAlertAction(title: NSLocalizedString("Я соглашаюсь", comment: ""), style: .default, handler: nil)
        alerNotice.addAction(action2)
        self.present(alerNotice, animated: true, completion: nil)
    }
   

    @objc func presentController() {
        let VC = storyboard?.instantiateViewController(withIdentifier: "register") as! RegistarationController
         self.present(VC, animated: true, completion: nil)
        }
    

    func setupSeg() {
      
        let attributes = [ NSAttributedString.Key.foregroundColor : UIColor.yellow,
                           NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.bold)];
        let attributesSelected = [ NSAttributedString.Key.foregroundColor : UIColor.black,
                                   NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.bold)];
  
        segmentControl.setTitleTextAttributes(attributes, for: UIControl.State.normal)
        segmentControl.setTitleTextAttributes(attributesSelected, for: UIControl.State.selected)
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentControl.selectedSegmentIndex == 0 {
            return soccerString.count
        }
        else if segmentControl.selectedSegmentIndex == 1 {
            return basketString.count
            
        
        }
        else if segmentControl.selectedSegmentIndex == 2 {
            return tennisString.count
        
        }
        return 0
    }
    
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let sportCell = tableView.dequeueReusableCell(withIdentifier: "sportCell", for: indexPath) as! TableViewCell
            
           
                if segmentControl.selectedSegmentIndex == 0  {
                  
            
                 let insertRow = (soccerString.count - 1) - indexPath.row
                 let soccer = soccerString[insertRow]
                    
                sportCell.matchLabel.text = soccer.matchS
                sportCell.viewsCounter.text = "\(soccer.following.roundedWithAbbreviations)"
                sportCell.bravoCounter.text = "\(soccer.bravissimo.roundedWithAbbreviations)"
               // sportCell.shareCounter.text = "\(soccer.shares.roundedWithAbbreviations)"
                sportCell.imageSport.image = UIImage(named: "soccer_ball")
                    if  sportCell.resultSoccer.image != nil {
                        sportCell.resultSoccer.image = UIImage(named: "")
                    }
                
                    soccer.resultS.getDataInBackground {(data, error) in
                        sportCell.resultSoccer.image = error == nil ? UIImage(data: data!) : nil
                    }
                
                    
                sportCell.titleSport.text = soccer.footbalTitle
                    if sportCell.imageMatch.image != nil {
                        sportCell.imageMatch.image = UIImage(named: "")
                    }
                soccer.imagePrS.getDataInBackground {(data, error) in
                        sportCell.imageMatch.image = error == nil ? UIImage(data: data!) : nil
                    }
                
                }
                else if segmentControl.selectedSegmentIndex == 1 {
                
                let newIndex = (basketString.count - 1) - indexPath.row
                let basket = basketString[newIndex]
                sportCell.matchLabel.text = basket.matchB
                
              //  sportCell.shareCounter.text = "\(basket.sharecount.roundedWithAbbreviations)"
                
                sportCell.viewsCounter.text = "\(basket.basketviews.roundedWithAbbreviations)"
               sportCell.bravoCounter.text = "\(basket.bravo.roundedWithAbbreviations)"
                sportCell.titleSport.text = basket.basketTitle
                sportCell.imageSport.image = UIImage(named: "basket_ball")
                    if  sportCell.resultSoccer.image != nil {
                        sportCell.resultSoccer.image = UIImage(named: "")
                    }
                    
                    basket.resultB.getDataInBackground {(data, error) in
                        sportCell.resultSoccer.image = error == nil ? UIImage(data: data!) : nil
                    }
                    
                    if sportCell.imageMatch.image != nil {
                        sportCell.imageMatch.image = UIImage(named: "")
                    }
                basketString[newIndex].imagePrB.getDataInBackground {(data, error) in
                        sportCell.imageMatch.image = error == nil ? UIImage(data: data!) : nil
                    }
                
                }  else if segmentControl.selectedSegmentIndex == 2 {
                 
                 let newInt = (tennisString.count - 1) - indexPath.row
                let tennis = tennisString[newInt]
                    sportCell.matchLabel.text = tennis.matchT
                    sportCell.titleSport.text = tennis.titleTen
                    sportCell.imageSport.image = UIImage(named: "tennis_ball")
                //    sportCell.shareCounter.text = "\(tennis.shareCount.roundedWithAbbreviations)"
                    sportCell.viewsCounter.text = "\(tennis.viewsTen.roundedWithAbbreviations)"
                    sportCell.bravoCounter.text = "\(tennis.bravoTen.roundedWithAbbreviations)"
                    
                    if  sportCell.resultSoccer.image != nil {
                        sportCell.resultSoccer.image = UIImage(named: "")
                    }
                    
                    tennis.resultT.getDataInBackground {(data, error) in
                        sportCell.resultSoccer.image = error == nil ? UIImage(data: data!) : nil
                    }
                    
                    if sportCell.imageMatch.image != nil {
                        sportCell.imageMatch.image = UIImage(named: "")
                    }
                    
                    tennis.imagePrT.getDataInBackground {(data, error) in
                        sportCell.imageMatch.image = error == nil ? UIImage(data: data!) : nil
                    }
                    
                 
            }
            
            
            
            sportCell.selectionStyle = UITableViewCell.SelectionStyle.none
            
          
            return sportCell
 }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = AnimationFactory.makeMoveUpWithFade(rowHeight: cell.frame.height, duration: 0.5, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    @objc func loadObjects1() {
        
        let query = Soccer.query() as! PFQuery<Soccer>
       //       query.fromLocalDatastore()
        query.findObjectsInBackground  { (objects, error) in
            if error == nil {
                self.soccerString = objects!
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
               
          
            
            } else {
                print(error!)
            }
        }
            }
    
    
        func loadObjects2() {
        let query = Basketball.query() as! PFQuery<Basketball>
            //  query.fromLocalDatastore()
            query.findObjectsInBackground  { (objects, error) in
            if error == nil {
                self.basketString = objects!
                self.tableView.reloadData()
             } else {
                print(error!)
            }
            
        }
    }
    
    func loadObjects3() {
        let query = Tennis.query() as! PFQuery<Tennis>
     //  query.fromLocalDatastore()
        query.findObjectsInBackground  { (objects, error) in
            if error == nil {
                self.tennisString = objects!
                self.tableView.reloadData()
            } else {
                print(error!)
            }
            
        }
    }
    
    
    
    @objc func obnova() {
            loadObjects1()
            loadObjects2()
            loadObjects3()
            tableView.reloadData()
            refresh.endRefreshing()
        
    
    }
    
   
    

    

    
    
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch (segmentControl.selectedSegmentIndex) {
            case 0 :
                if segue.identifier == "showSoccer" {
                   
                let destationViewController = segue.destination as! DetailSoccerTableViewController
                    if let indexPath = tableView.indexPathForSelectedRow {

                  let row = Int((soccerString.count-1)-indexPath.row)
                 
                 soccerString[row].following += 1
                  
                destationViewController.detailSoccer = soccerString[row]
                    
                soccerString[row].saveInBackground()
                   
                        
                    }
            }
            
          case 1 :
                if segue.identifier == "showBasket" {
                    let dvc = segue.destination as! DetailBasketViewController
                    if let indexPath = tableView.indexPathForSelectedRow {
                        let row = Int((basketString.count-1)-indexPath.row)
                        basketString[row].basketviews += 1
                        dvc.baskets = basketString[row]
                        basketString[row].saveInBackground()
                        
                    }
        
            }
            
             case 2 :
                if segue.identifier == "showTen" {
                let destationVC: DetailTennisViewController = segue.destination as! DetailTennisViewController
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    let row = Int((tennisString.count-1)-indexPath.row)
                    tennisString[row].viewsTen += 1
                    destationVC.tenises = tennisString[row]
                    tennisString[row].saveInBackground()
                    
                   }
                }
                default :
                break
            
            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentControl.selectedSegmentIndex == 0 {
           self.performSegue(withIdentifier: "showSoccer", sender: self)
            
        } else if segmentControl.selectedSegmentIndex == 1 {
            self.performSegue(withIdentifier: "showBasket", sender: self)
            
        } else if segmentControl.selectedSegmentIndex == 2 {
            
            self.performSegue(withIdentifier: "showTen", sender: self)
        }
    }
    
    
    enum AnimationFactory {
        
        static func makeFade(duration: TimeInterval, delayFactor: Double) -> Animation {
            return { cell, indexPath, _ in
                cell.alpha = 0
                
                UIView.animate(
                    withDuration: duration,
                    delay: delayFactor * Double(indexPath.row),
                    animations: {
                        cell.alpha = 1
                })
            }
        }
        
        static func makeMoveUpWithBounce(rowHeight: CGFloat, duration: TimeInterval, delayFactor: Double) -> Animation {
            return { cell, indexPath, tableView in
                cell.transform = CGAffineTransform(translationX: 0, y: rowHeight)
                
                UIView.animate(
                    withDuration: duration,
                    delay: delayFactor * Double(indexPath.row),
                    usingSpringWithDamping: 0.4,
                    initialSpringVelocity: 0.1,
                    options: [.curveEaseInOut],
                    animations: {
                        cell.transform = CGAffineTransform(translationX: 0, y: 0)
                })
            }
        }
        
        static func makeSlideIn(duration: TimeInterval, delayFactor: Double) -> Animation {
            return { cell, indexPath, tableView in
                cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)
                
                UIView.animate(
                    withDuration: duration,
                    delay: delayFactor * Double(indexPath.row),
                    options: [.curveEaseInOut],
                    animations: {
                        cell.transform = CGAffineTransform(translationX: 0, y: 0)
                })
            }
        }
        
        static func makeMoveUpWithFade(rowHeight: CGFloat, duration: TimeInterval, delayFactor: Double) -> Animation {
            return { cell, indexPath, tableView in
                cell.transform = CGAffineTransform(translationX: 0, y: rowHeight / 2)
                cell.alpha = 0
                
                UIView.animate(
                    withDuration: duration,
                    delay: delayFactor * Double(indexPath.row),
                    options: [.curveEaseInOut],
                    animations: {
                        cell.transform = CGAffineTransform(translationX: 0, y: 0)
                        cell.alpha = 1
                })
            }
        }
    }

    
    
    
}
    




