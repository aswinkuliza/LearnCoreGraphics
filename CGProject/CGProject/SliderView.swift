//
//  SliderView.swift
//  CGProject
//
//  Created by kuliza310 on 7/23/18.
//  Copyright © 2018 kuliza310. All rights reserved.
//

import UIKit
@IBDesignable
class SliderView: UIView {

    private var widthOfSlider: CGFloat {
        return bounds.width - 2 * offsetWidth
    }
    private let baseLayer = CAShapeLayer()
    private let descreteLayer = CAShapeLayer()
    private let buttonLayer = CAShapeLayer()
    private let heightOfBaseTicks: CGFloat = 32.0
    private let heightOfDescreteTicks: CGFloat = 16.0
    private let tickWidth: CGFloat = 5.0
    private let offsetWidth: CGFloat = 16.0
    private var panGesture: UIPanGestureRecognizer {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panApplied(_:)))
        return gesture
    }
    private var lastPoint: CGPoint = .zero

    @IBInspectable var sliderColor = UIColor.blue
    @IBInspectable var buttonColor = UIColor.white
    @IBInspectable var numberOfDivisions: CGFloat = 8.0

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }

    private func setup() {
        setupBaseLayer()
        setupDescreteLayer()
        setupButtonLayer(at: CGPoint(x: offsetWidth, y: center.y))
        setupPan()
    }

    private func setupBaseLayer() {
        layer.addSublayer(baseLayer)
        baseLayer.strokeColor = sliderColor.cgColor
        let startPoint = CGPoint(x: offsetWidth, y: center.y)
        let path = UIBezierPath()
        path.move(to: startPoint)
        let endPoint = CGPoint(x: bounds.width - offsetWidth, y: center.y)
        path.addLine(to: endPoint)
        let leftTickStartPoint = CGPoint(x: offsetWidth, y: center.y + heightOfBaseTicks / 2)
        path.move(to: leftTickStartPoint)
        let leftTickEndPoint = CGPoint(x: offsetWidth, y: center.y - heightOfBaseTicks / 2)
        path.addLine(to: leftTickEndPoint)
        let rightTickStartPoint = CGPoint(x: bounds.width - offsetWidth, y: center.y + heightOfBaseTicks / 2)
        path.move(to: rightTickStartPoint)
        let rightTickEndPoint = CGPoint(x: bounds.width - offsetWidth, y: center.y - heightOfBaseTicks / 2)
        path.addLine(to: rightTickEndPoint)
        baseLayer.path = path.cgPath
        baseLayer.lineWidth = tickWidth
    }

    private func setupDescreteLayer() {
        layer.addSublayer(descreteLayer)
        descreteLayer.strokeColor = UIColor.red.cgColor
        descreteLayer.lineWidth = heightOfDescreteTicks
        var lineDashPattern = [NSNumber]()
        let space = (widthOfSlider - ((numberOfDivisions) * tickWidth)) / numberOfDivisions
        lineDashPattern.append(NSNumber(value: Float(tickWidth)))
        lineDashPattern.append(NSNumber(value: Float(space)))
        descreteLayer.lineDashPattern = lineDashPattern
        let startPoint = CGPoint(x: offsetWidth - tickWidth / 2, y: center.y)
        let path = UIBezierPath()
        path.move(to: startPoint)
        let endPoint = CGPoint(x: bounds.width - offsetWidth + tickWidth / 2, y: center.y)
        path.addLine(to: endPoint)
        descreteLayer.path = path.cgPath
    }

    private func setupButtonLayer(at point: CGPoint) {
        layer.addSublayer(buttonLayer)
        buttonLayer.fillColor = buttonColor.cgColor
        buttonLayer.strokeColor = buttonColor.cgColor
        let path = UIBezierPath(arcCenter: point, radius: heightOfDescreteTicks, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        buttonLayer.anchorPoint = CGPoint.zero
        buttonLayer.path = path.cgPath
        buttonLayer.shadowRadius = 2
        buttonLayer.shadowColor = UIColor.darkGray.cgColor
        buttonLayer.shadowOpacity = 0.7
        buttonLayer.shadowOffset = CGSize(width: 0, height: 0)
    }

    private func setupPan() {
        addGestureRecognizer(panGesture)
    }

    private func updateButtonLayer(at point: CGPoint) {
        let newX = max(min(point.x + lastPoint.x, widthOfSlider), offsetWidth)
        let newPoint = CGPoint(x: newX, y: 0)
        buttonLayer.position = newPoint
    }

    @objc private func panApplied(_ sender: UIPanGestureRecognizer) {
        guard sender.state != .cancelled || sender.state != .ended || sender.state != .failed else {
            return
        }
        let newX = sender.location(in: sender.view).x
        let newPoint = CGPoint(x: newX, y: center.y)
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        updateButtonLayer(at: newPoint)
        CATransaction.commit()
        lastPoint = newPoint
    }
}
