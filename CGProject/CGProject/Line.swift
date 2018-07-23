//
//  Line.swift
//  CGProject
//
//  Created by kuliza310 on 7/20/18.
//  Copyright © 2018 kuliza310. All rights reserved.
//

import Foundation
import UIKit

class Line: CAShapeLayer {
    private let starLayer = CAShapeLayer()

    override init() {
        super.init()
        drawLine()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        drawLine()
    }

    private func drawLine() {
        addSublayer(starLayer)
        starLayer.strokeColor = UIColor.darkGray.cgColor
        starLayer.lineWidth = 3.0
        starLayer.strokeEnd = 1
        starLayer.strokeStart = 1
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 15, y: 0))
        let endPointX = arc4random_uniform(100) + 25
        path.addLine(to: CGPoint(x: Double(endPointX), y: 0.0))
        starLayer.path = path.cgPath
        starLayer.lineCap = kCALineCapRound
    }


    func animate() {
        let duration = 0.5
        let pathAnimation = CABasicAnimation(keyPath: "strokeStart")
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1
        pathAnimation.repeatCount = .greatestFiniteMagnitude
        pathAnimation.fillMode = kCAFillModeBackwards
        pathAnimation.beginTime = duration * 0.15
        pathAnimation.duration = duration * 0.85
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        pathAnimation.autoreverses = false

        let pathAnimation2 = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation2.fromValue = 0
        pathAnimation2.toValue = 1
        pathAnimation2.repeatCount = .greatestFiniteMagnitude
        pathAnimation2.fillMode = kCAFillModeForwards
        pathAnimation2.duration = duration * 0.75
        pathAnimation2.beginTime = 0
        pathAnimation2.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        pathAnimation2.autoreverses = false

        let pathAnimation3 = CABasicAnimation(keyPath: "strokeColor")
        pathAnimation3.fromValue = UIColor.white.cgColor
        pathAnimation3.toValue = UIColor.random().cgColor
        pathAnimation3.duration = duration
        pathAnimation3.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = duration
        animationGroup.animations = [pathAnimation, pathAnimation2, pathAnimation3]
        starLayer.add(animationGroup, forKey: "move")
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
