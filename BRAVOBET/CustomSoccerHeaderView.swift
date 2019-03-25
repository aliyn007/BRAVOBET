//
//  CustomSoccerHeaderView.swift
//  BRAVOBET
//
//  Created by Александр on 27.02.2018.
//  Copyright © 2018 Aleksandr Ilyin. All rights reserved.
//



import UIKit

class CustomSoccerHeaderView: UITableViewHeaderFooterView {
    
    
   
    
    
    var clickBravisso: Soccer?
    @IBOutlet weak var bravoBtn: UIButton!{
        didSet {
            bravoBtn.layer.cornerRadius = bravoBtn.frame.size.width/2
            bravoBtn.layer.masksToBounds = true
            bravoBtn.layer.borderWidth = 2
            bravoBtn.layer.borderColor = UIColor.black.cgColor
            
        }
    }
    
    
    
    
    @IBOutlet weak var countBravo: UILabel!
    @IBAction func likeBtn(_ sender: UIButton) {
       likeTap()
      // функция дрожания
        sender.flash()
        if var clikBravo = clickBravisso?.bravissimo   {
            print("clikBravo")
            clikBravo += 1
            clickBravisso!.setObject(clikBravo, forKey: "bravissimo")
            clickBravisso!.saveInBackground()
            countBravo.text = "\(clikBravo)"
        } else {
            fatalError("clikBravo is null")
        }
    }
    
    @IBOutlet weak var nameHeader: UILabel!
    @IBOutlet weak var imageHeader: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bravoBtn.addTarget(self, action: #selector(likeBtn(_:)), for: .touchUpInside)
       
    
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
    path.move(to:CGPoint(x:bravoBtn.layer.position.x, y: bravoBtn.layer.position.y))
    let endPoint = CGPoint(x: -100, y: -100)
    let randomYShift = 100+drand48()*300
    let controlP1 = CGPoint(x: 150, y: 200-randomYShift)
    let controlP2 = CGPoint(x: 100, y: 100+randomYShift)
    
    path.addCurve(to: endPoint, controlPoint1: controlP1, controlPoint2: controlP2)
    return path

}

}

