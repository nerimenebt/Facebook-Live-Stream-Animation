//
//  ViewController.swift
//  FBStreamAnimations
//
//  Created by Nerimene  on 11/05/2018.
//  Copyright © 2018 Nerimene . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let curvedView = CurvedView(frame: view.frame)
//        curvedView.backgroundColor = .yellow
//        view.addSubview(curvedView)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc func handleTap() {
        (0...10).forEach { (_) in
            generateAnimatedViews()
        }
    }
    
    @objc fileprivate func generateAnimatedViews() {
        
        let image = drand48() > 0.5 ? #imageLiteral(resourceName: "Facebook-Like") : #imageLiteral(resourceName: "facebook-circle-heart-love-png-4")
        let imageView = UIImageView(image: image)
        let dimension = 20 + drand48() * 10
        imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customPath().cgPath
        animation.duration = 2 + drand48() * 3
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        imageView.layer.add(animation, forKey: nil)
        view.addSubview(imageView)
    }
}

func customPath() -> UIBezierPath {
    let path = UIBezierPath()
    path.move (to: CGPoint(x: 0, y: 200))
    let endPoint = CGPoint(x: 400, y: 200)
    let randomYShift = 200 + drand48() * 300
    let cp1 = CGPoint(x: 100, y: 100 - randomYShift)
    let cp2 = CGPoint(x: 200, y: 300 + randomYShift)
    path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
    return path
}

class CurvedView: UIView {
    override func draw(_ rect: CGRect) {
        let path = customPath()
        path.lineWidth = 3
        path.stroke()
    }
}
