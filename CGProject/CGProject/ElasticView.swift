//
//  ElasticView.swift
//  CGProject
//
//  Created by kuliza310 on 7/23/18.
//  Copyright © 2018 kuliza310. All rights reserved.
//

import UIKit

class ElasticView: UIView {

    private let elasticShape = CAShapeLayer()
    private let minimumHeight: CGFloat = 150.0
    private let panGestureRecognizer = UIPanGestureRecognizer()
    private let l1ControlPointView = UIView()
    private let l2ControlPointView = UIView()
    private let l3ControlPointView = UIView()
    private let cControlPointView = UIView()
    private let r1ControlPointView = UIView()
    private let r2ControlPointView = UIView()
    private let r3ControlPointView = UIView()
    private let maxWaveHeight: CGFloat = 100.0
    private lazy var displayLink: CADisplayLink =  {
        let link = CADisplayLink(target: self, selector: #selector(updateShape))
        link.add(to: .main, forMode: .defaultRunLoopMode)
        link.isPaused = true
        return link
    }()

    private var animating = false {
        didSet {
            isUserInteractionEnabled = !animating
            displayLink.isPaused = !animating
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    private func setup() {
        setupElasticLayer()
        setupGestureRecognizer()
        setupControlPoints()
    }

    private func setupElasticLayer() {
        layer.addSublayer(elasticShape)
        elasticShape.frame = CGRect(x: 0, y: 0, width: bounds.width, height: minimumHeight)
        elasticShape.backgroundColor = UIColor.darkGray.cgColor
    }

    private func setupControlPoints() {
        l1ControlPointView.frame = CGRect(x: 0, y: 0, width: 3, height: 3)
        l1ControlPointView.backgroundColor = .red
        addSubview(l1ControlPointView)

        l2ControlPointView.frame = CGRect(x: 0, y: 0, width: 3, height: 3)
        l2ControlPointView.backgroundColor = .red
        addSubview(l2ControlPointView)

        l3ControlPointView.frame = CGRect(x: 0, y: 0, width: 3, height: 3)
        l3ControlPointView.backgroundColor = .red
        addSubview(l3ControlPointView)

        cControlPointView.frame = CGRect(x: 0, y: 0, width: 3, height: 3)
        cControlPointView.backgroundColor = .red
        addSubview(cControlPointView)

        r1ControlPointView.frame = CGRect(x: 0, y: 0, width: 3, height: 3)
        r1ControlPointView.backgroundColor = .red
        addSubview(r1ControlPointView)

        r2ControlPointView.frame = CGRect(x: 0, y: 0, width: 3, height: 3)
        r2ControlPointView.backgroundColor = .red
        addSubview(r2ControlPointView)

        r3ControlPointView.frame = CGRect(x: 0, y: 0, width: 3, height: 3)
        r3ControlPointView.backgroundColor = .red
        addSubview(r3ControlPointView)
    }

    private func setupGestureRecognizer() {
        addGestureRecognizer(panGestureRecognizer)
        panGestureRecognizer.addTarget(self, action: #selector(panGestureApplied(_:)))
    }

    @objc private func panGestureApplied(_ sender: UIPanGestureRecognizer) {
        guard (sender.state != .cancelled && sender.state != .ended && sender.state != .failed) else {
            animating = true
            let centerY = minimumHeight
            UIView.animate(withDuration: 0.9, delay: 0.0, usingSpringWithDamping: 0.57, initialSpringVelocity: 0.0, options: [], animations: {
                self.l1ControlPointView.center.y = centerY
                self.l2ControlPointView.center.y = centerY
                self.l3ControlPointView.center.y = centerY
                self.cControlPointView.center.y = centerY
                self.r1ControlPointView.center.y = centerY
                self.r2ControlPointView.center.y = centerY
                self.r3ControlPointView.center.y = centerY
            }, completion: { _ in
                self.animating = false
            })
            return
        }
        let additionalHeight = max(sender.translation(in: sender.view).y, 0)
        let waveHeight = min(additionalHeight * 0.6, maxWaveHeight)
        let baseHeight = minimumHeight + additionalHeight - waveHeight
        let locationX = sender.location(in: sender.view).x
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        layoutControlPoints(baseHeight: baseHeight, waveHeight: waveHeight, locationX: locationX)
        updateShape()
        CATransaction.commit()
    }

    @objc private func updateShape() {
        elasticShape.path = currentPath()
    }

    private func currentPath() -> CGPath {
        let path = UIBezierPath()
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint(x: 0,
                                 y: l3ControlPointView.getCenter(currentPath: false).y))
        path.addCurve(to: l1ControlPointView.getCenter(currentPath: animating),
                      controlPoint1: l3ControlPointView.getCenter(currentPath: animating),
                      controlPoint2: l2ControlPointView.getCenter(currentPath: animating))
        path.addCurve(to: r1ControlPointView.getCenter(currentPath: animating),
                      controlPoint1: cControlPointView.getCenter(currentPath: animating),
                      controlPoint2: r1ControlPointView.getCenter(currentPath: animating))
        path.addCurve(to: r3ControlPointView.getCenter(currentPath: animating),
                      controlPoint1: r1ControlPointView.getCenter(currentPath: animating),
                      controlPoint2: r2ControlPointView.getCenter(currentPath: animating))
        path.addLine(to: CGPoint(x: bounds.width, y: 0))
        path.close()
        return path.cgPath
    }

    private func layoutControlPoints(baseHeight: CGFloat, waveHeight: CGFloat, locationX: CGFloat) {
        let width = bounds.width
        let minLeftX = min((locationX - width / 2.0) * 0.28, 0.0)
        let maxRightX = max(width + (locationX - width / 2.0) * 0.28, width)

        let leftPartWidth = locationX - minLeftX
        let rightPartWidth = maxRightX - locationX

        l3ControlPointView.center = CGPoint(x: minLeftX, y: baseHeight)
        l2ControlPointView.center = CGPoint(x: minLeftX + leftPartWidth * 0.44, y: baseHeight)
        l1ControlPointView.center = CGPoint(x: minLeftX + leftPartWidth * 0.71, y: baseHeight + waveHeight * 0.64)
        cControlPointView.center = CGPoint(x: locationX , y: baseHeight + waveHeight * 1.36)
        r1ControlPointView.center = CGPoint(x: maxRightX - rightPartWidth * 0.71, y: baseHeight + waveHeight * 0.64)
        r2ControlPointView.center = CGPoint(x: maxRightX - (rightPartWidth * 0.44), y: baseHeight)
        r3ControlPointView.center = CGPoint(x: maxRightX, y: baseHeight)
    }
}

extension UIView {
    func getCenter(currentPath: Bool = true) -> CGPoint {
        guard currentPath == true, let currentCenter = layer.presentation()?.position else { return center }
        return currentCenter
    }
}
