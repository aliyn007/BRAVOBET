//
//  HeaderTennisCustomTableViewCell.swift
//  BRAVOBET
//
//  Created by Александр on 05.09.2018.
//  Copyright © 2018 Aleksandr Ilyin. All rights reserved.
//

import UIKit

class HeaderTennisCustomTableViewCell: UITableViewHeaderFooterView {

    var clickTennis:Tennis?
    
    
    @IBOutlet weak var imageTennis: UIImageView!
    
    
    @IBOutlet weak var titleTennis: UILabel!
    
    
    @IBOutlet weak var bravoTennisCount: UILabel!
    
    @IBOutlet weak var btnBravoTennis: UIButton! {
        didSet {
            btnBravoTennis.layer.cornerRadius = btnBravoTennis.frame.size.width/2
            btnBravoTennis.layer.masksToBounds = true
            btnBravoTennis.layer.borderWidth = 2
            btnBravoTennis.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnBravoTennis.addTarget(self, action: #selector(btnBravoTennis(_:)), for: .touchUpInside)
    }
    
    @IBAction func btnBravoTennis(_ sender: UIButton) {
        sender.pulsate()
        likeTap()
        if var clikBravo = clickTennis?.bravoTen  {
            print("clikBravo")
            clikBravo += 1
            clickTennis!.setObject(clikBravo, forKey: "bravoTen")
            clickTennis!.saveInBackground()
            bravoTennisCount.text = "\(clikBravo)"
        } else {
            fatalError("clikBravo is null")
            
            
        }
    }
    
    
    
    override func draw(_ rect: CGRect) {
        // saddasd dsad dsad asdas
        let path = customPath()
        path.lineWidth = 3
        path.stroke()
        
    }
    
    func likeTap() {
        (0...15).forEach { (_)  in
            
            generateAnimationView()
            
        }
    }
    
    func generateAnimationView() {
        let image = drand48() > 0.7 ? #imageLiteral(resourceName: "money"): #imageLiteral(resourceName: "bravos")
        let imageView = UIImageView(image: image)
        
        let demision = 10+drand48()*20
        imageView.frame = CGRect(x: 0, y: 0, width: demision, height:demision)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customPath().cgPath
        animation.duration = 2 * drand48() * 4
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        let nameString = CAMediaTimingFunctionName.easeOut
        animation.timingFunction = CAMediaTimingFunction(name: nameString)
        imageView.layer.add(animation, forKey: nil)
        contentView.addSubview(imageView)
        
        
    }
    
    func customPath()->UIBezierPath {
        
        
        let path = UIBezierPath()
        path.move(to:CGPoint(x:btnBravoTennis.layer.position.x, y: btnBravoTennis.layer.position.y))
        let endPoint = CGPoint(x: -100, y: -100)
        let randomYShift = 100+drand48()*300
        let controlP1 = CGPoint(x: 150, y: 200-randomYShift)
        let controlP2 = CGPoint(x: 100, y: 100+randomYShift)
        
        path.addCurve(to: endPoint, controlPoint1: controlP1, controlPoint2: controlP2)
        return path
        
    }
    
    

    
}
