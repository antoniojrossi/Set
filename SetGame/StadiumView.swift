//
//  StadiumView.swift
//  SetGame
//
//  Created by Antonio J Rossi on 09/07/2019.
//  Copyright © 2019 Antonio J Rossi. All rights reserved.
//

import UIKit

class StadiumView: ShapeView {

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        let leftCenter = CGPoint(x: bounds.origin.x + bounds.midY, y: bounds.midY)
        let rightCenter = CGPoint(x: bounds.maxX - bounds.midY, y: bounds.midY)
        let radius = bounds.midY - (2 * lineWidth)
        path.addArc(withCenter: leftCenter, radius: radius, startAngle: 3 * CGFloat.pi / 2, endAngle: CGFloat.pi / 2, clockwise: false)
        path.addArc(withCenter: rightCenter, radius: radius, startAngle: CGFloat.pi / 2, endAngle: 3 * CGFloat.pi / 2, clockwise: false)
        path.close()
        applyShading(to: path)
    }
}
