//
//  PushButton.swift
//  Flo
//
//  Created by kuliza310 on 6/4/18.
//  Copyright © 2018 kuliza310. All rights reserved.
//

import UIKit

@IBDesignable
class PushButton: UIButton {
    private struct Constants {
        static let plusLineWidth: CGFloat = 3.0
        static let plusButtonScale: CGFloat = 0.6
        static let halfPointShift: CGFloat = 0.5
    }

    private var halfWidth: CGFloat {
        return bounds.width / 2
    }

    private var halfHeight: CGFloat {
        return bounds.height / 2
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let path = UIBezierPath(ovalIn: rect)
        UIColor.green.setFill()
        path.fill()

        let plusWidth: CGFloat = min(bounds.width, bounds.height) * Constants.plusButtonScale
        let halfPlusWidth = plusWidth / 2

        let plusPath = UIBezierPath()
        plusPath.lineWidth = Constants.plusLineWidth
        // Note: - understand half point shift super clear.
        plusPath.move(to: CGPoint(x: halfWidth - halfPlusWidth + Constants.halfPointShift,
                                  y: halfHeight + Constants.halfPointShift))
        plusPath.addLine(to: CGPoint(x: halfWidth + halfPlusWidth + Constants.halfPointShift,
                                     y: halfHeight + Constants.halfPointShift))

        plusPath.move(to: CGPoint(x: halfWidth + Constants.halfPointShift,
                                  y: halfHeight - halfPlusWidth + Constants.halfPointShift))
        plusPath.addLine(to: CGPoint(x: halfWidth + Constants.halfPointShift,
                                     y: halfHeight + halfPlusWidth + Constants.halfPointShift))

        UIColor.white.setStroke()
        plusPath.stroke()
    }
}
