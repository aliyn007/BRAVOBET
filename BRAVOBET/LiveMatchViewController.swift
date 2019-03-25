//
//  LiveMatchViewController.swift
//  BRAVOBET
//
//  Created by Александр on 10/28/18.
//  Copyright © 2018 Aleksandr ILIN. All rights reserved.
//

import UIKit
import Parse

class LiveMatchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    var liveMatch = [LiveMatch]()
    
    @objc var refresh : UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    typealias Animation = (UITableViewCell, IndexPath, UITableView) -> Void
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = NSLocalizedString("Live match", comment: "")
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
       
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 4.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 1.0
        self.navigationController?.navigationBar.layer.masksToBounds = false
        
        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.loadObjects3()
        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: NSLocalizedString("Обновить", comment: "Обновить"))
        
        refresh.tintColor = UIColor.white
        refresh.addTarget(self, action:#selector(obnova), for: UIControl.Event.valueChanged)
        
        tableView.addSubview(refresh)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       self.navigationController?.hidesBarsOnSwipe = true
       self.navigationController?.setNavigationBarHidden(false, animated: true)
        
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
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return liveMatch.count
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
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cellMatch = tableView.dequeueReusableCell(withIdentifier: "cellLive") as! LiveMatchTableViewCell
        let oneIn = (liveMatch.count - 1) - indexPath.row
        let matchLive = liveMatch[oneIn]
        cellMatch.nameMatch.text = matchLive.nameMatchLive
        cellMatch.betMatch.text = matchLive.forecasts
        
        let df = DateFormatter()
        df.dateStyle = .long
        df.dateFormat = "dd.MM.yyyy"
        df.locale = Locale(identifier: "ru_UA")
        df.doesRelativeDateFormatting = true
        
        let timeNew = matchLive.createdAt
        //cell.dataLabel.text = df.string(from: timeNew!)
        cellMatch.timePost.text = timeNew?.getPastTime(for: timeNew!)
         cellMatch.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cellMatch
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = AnimationFactory.makeSlideIn(duration: 0.5, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
    
    
    func loadObjects3() {
        let query = LiveMatch.query() as! PFQuery<LiveMatch>
        //  query.fromLocalDatastore()
        query.findObjectsInBackground  { (objects, error) in
            if error == nil {
                self.liveMatch = objects!
                self.tableView.reloadData()
            } else {
                print(error!)
            }
            
        }

}
    
    
    
    
    







    
    
    
    @objc func obnova() {
        
        loadObjects3()
        tableView.reloadData()
        refresh.endRefreshing()
        
        
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





