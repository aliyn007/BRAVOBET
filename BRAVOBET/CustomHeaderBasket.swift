//
//  CustomHeaderBasket.swift
//  BRAVOBET
//
//  Created by Александр on 20.04.2018.
//  Copyright © 2018 Aleksandr Ilyin. All rights reserved.
//

import UIKit

class CustomHeaderBasket: UITableViewHeaderFooterView {
    
    
    var clickBasket: Basketball?
    
    
    
    @IBOutlet weak var imageBasket: UIImageView!
    @IBOutlet weak var titleBasket: UILabel!{
        didSet {
            
        }
    }
    @IBOutlet weak var countLikeBasket: UILabel!
    
    @IBOutlet weak var outletBasketBtn: UIButton!{
        didSet {
            outletBasketBtn.layer.cornerRadius = outletBasketBtn.frame.size.width/2
            outletBasketBtn.layer.masksToBounds = true
            outletBasketBtn.layer.borderWidth = 2
            outletBasketBtn.layer.borderColor = UIColor.black.cgColor
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        outletBasketBtn.addTarget(self, action: #selector(actionLikeBasket(_:)), for: .touchUpInside)
    }

    @IBAction func actionLikeBasket(_ sender: UIButton) {
        sender.shake()
        likeTap()
        
        if var clikBravoBasket = clickBasket?.bravo  {
        
            
            clikBravoBasket += 1
            
            clickBasket!.setObject(clikBravoBasket, forKey: "bravo")
            clickBasket!.saveInBackground()
            countLikeBasket.text = "\(clikBravoBasket)"
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
    path.move(to:CGPoint(x:outletBasketBtn.layer.position.x, y: outletBasketBtn.layer.position.y))
    let endPoint = CGPoint(x: -100, y: -100)
    let randomYShift = 100+drand48()*300
    let controlP1 = CGPoint(x: 150, y: 200-randomYShift)
    let controlP2 = CGPoint(x: 100, y: 100+randomYShift)
    
    path.addCurve(to: endPoint, controlPoint1: controlP1, controlPoint2: controlP2)
    return path
    
}

}
