//
//  FanView.swift
//  CGProject
//
//  Created by kuliza310 on 7/5/18.
//  Copyright © 2018 kuliza310. All rights reserved.
//

import UIKit
@IBDesignable
class StarView: UIView {

    private let starLayer =  CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func setup() {
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(starLayer)
        backgroundLayer.strokeColor = UIColor.lightGray.cgColor
        backgroundLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        backgroundLayer.lineWidth = 3
        starLayer.fillColor = UIColor.white.cgColor
        starLayer.strokeColor = UIColor.orange.cgColor
        starLayer.lineWidth = 3
        starLayer.lineJoin = kCALineJoinRound
        let path = UIBezierPath()
        let numberOfPoints = 5
        let numberOfLineSegments = 2 * numberOfPoints
        let theta = CGFloat(Double.pi / Double(numberOfPoints))
        let innerRadius = 50.0
        let outerRadius = bounds.height
        for i in 0..<numberOfLineSegments {
            let radius = i % 2 == 0 ? CGFloat(innerRadius) : outerRadius
            let x1 = bounds.width / 2 + cos(CGFloat(i) * theta) * CGFloat(radius)
            let y1 = sin(CGFloat(i) * theta) * CGFloat(radius)
            let pointOnCircle = CGPoint(x: x1, y: y1)
            if i == 0 {
                path.move(to: pointOnCircle)
            } else {
                path.addLine(to: pointOnCircle)
            }
        }
        path.close()
        starLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        backgroundLayer.lineDashPattern = [10]
        starLayer.strokeEnd = 1
        starLayer.strokeStart = 1
        let animationPath = CABasicAnimation(keyPath: "strokeEnd")
        animationPath.toValue = 1
        animationPath.autoreverses = true
        animationPath.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animationPath.duration = 5
        animationPath.repeatCount = .greatestFiniteMagnitude
        starLayer.add(animationPath, forKey: "pathAnimation")
    }
}
