//
//  SquiggleView.swift
//  SetGame
//
//  Created by Antonio J Rossi on 09/07/2019.
//  Copyright © 2019 Antonio J Rossi. All rights reserved.
//

import UIKit

class SquiggleView: ShapeView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        let dX = bounds.width / 100
        let dY = bounds.height / 100
        let originX = bounds.origin.x
        let originY = bounds.origin.y
        
        let points: [CGPoint] = [
            CGPoint(x: originX + (dX * 0), y: originY + (dY * 50)),
            CGPoint(x: originX + (dX * 10), y: originY + (dY * 5)),
            CGPoint(x: originX + (dX * 30), y: originY + (dY * 7)),
            CGPoint(x: originX + (dX * 50), y: originY + (dY * 20)),
            CGPoint(x: originX + (dX * 65), y: originY + (dY * 25)),
            CGPoint(x: originX + (dX * 85), y: originY + (dY * 0)),
            CGPoint(x: originX + (dX * 90), y: originY + (dY * 5)),
            CGPoint(x: originX + (dX * 100), y: originY + (dY * 50)),
            CGPoint(x: originX + (dX * 90), y: originY + (dY * 95)),
            CGPoint(x: originX + (dX * 70), y: originY + (dY * 93)),
            CGPoint(x: originX + (dX * 50), y: originY + (dY * 80)),
            CGPoint(x: originX + (dX * 35), y: originY + (dY * 75)),
            CGPoint(x: originX + (dX * 15), y: originY + (dY * 100)),
            CGPoint(x: originX + (dX * 10), y: originY + (dY * 95)),
            CGPoint(x: originX + (dX * 0), y: originY + (dY * 50)),
            CGPoint(x: originX + (dX * 10), y: originY + (dY * 5))
        ]
        
        var startPoint = CGPoint()
        var previousPoint = CGPoint()
        
        for (index, point) in points.enumerated() {
            switch index {
            case 0:
                startPoint = point
            case 1:
                path.move(to: startPoint.midPoint(to: point))
                previousPoint = point
            default:
                path.addQuadCurve(to: previousPoint.midPoint(to: point), controlPoint: previousPoint)
                previousPoint = point
            }
        }
        path.addQuadCurve(to: previousPoint.midPoint(to: startPoint), controlPoint: previousPoint)
        path.close()
        applyShading(to: path)
    }
}
