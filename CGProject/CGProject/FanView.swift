//
//  FanView.swift
//  CGProject
//
//  Created by kuliza310 on 7/5/18.
//  Copyright © 2018 kuliza310. All rights reserved.
//

import UIKit
@IBDesignable
class FanView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    private let fanShapeLayer =  CAShapeLayer()
    private let circleShapeLayer = CAShapeLayer()
    private let theta = CGFloat(Double.pi * 2 / Double(10))
    private let maskLayer = CAShapeLayer()

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
//        setup()
        drawPop()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        backgroundColor = UIColor.blue
        maskLayer.frame = bounds
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: 100)
        maskLayer.path = path.cgPath
        maskLayer.fillRule = kCAFillRuleNonZero
        layer.mask = maskLayer
    }

    private func drawPop() {
        for i in 1...10 {
            let line = Line()
            layer.addSublayer(line)
            layer.position = center
            line.transform = CATransform3DMakeRotation(CGFloat(i) * theta, 0, 0, 1)
            line.animate()
        }
    }
}
