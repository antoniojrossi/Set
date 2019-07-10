//
//  DiamondView.swift
//  SetGame
//
//  Created by Antonio J Rossi on 09/07/2019.
//  Copyright © 2019 Antonio J Rossi. All rights reserved.
//

import UIKit

class DiamondView: ShapeView {

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.minX + ShapeView.lineWidth, y: bounds.midY))
        path.addLine(to: CGPoint(x: bounds.midX, y: bounds.minY + ShapeView.lineWidth))
        path.addLine(to: CGPoint(x: bounds.maxX - ShapeView.lineWidth, y: bounds.midY))
        path.addLine(to: CGPoint(x: bounds.midX, y: bounds.maxY - ShapeView.lineWidth))
        path.close()
        applyShading(to: path)
    }
}
