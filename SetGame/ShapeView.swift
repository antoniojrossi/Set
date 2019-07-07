//
//  ShapeView.swift
//  SetGame
//
//  Created by Antonio J Rossi on 07/07/2019.
//  Copyright © 2019 Antonio J Rossi. All rights reserved.
//

import UIKit

@IBDesignable
class ShapeView: UIView {
    
    enum Shading {
        case solid
        case striped
        case open
    }
    
    enum Shape {
        case diamond
        case squiggle
        case stadium
    }
    
    // TODO: Refactorizar tanto switch
    // TODO: Seguramente haya que calcular este valor con proporción al tamaño de la carta
    static let lineWidth: CGFloat = 2.0
    static let stripeWidth: CGFloat = 3.0
    
    var color: UIColor = UIColor.black
    var shading: Shading = .open
    var shape: Shape = .diamond
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        switch shape {
        case .diamond:
            drawDiamond(path)
        case .stadium:
            drawStadium(path)
        default:
            break
        }
        path.close()
        switch shading {
        case .solid:
            fillSolid(path)
        case .open:
            fillOpen(path)
        case .striped:
            fillStriped(path)
        }
    }
    
    private func fillOpen(_ path: UIBezierPath) {
        path.lineWidth = ShapeView.lineWidth
        color.setStroke()
        path.stroke()
    }
    
    private func fillSolid(_ path: UIBezierPath) {
        color.setFill()
        path.fill()
    }
    
    private func fillStriped(_ path: UIBezierPath) {
        path.addClip()
        var lastColor = color
        for offsetX in stride(from: bounds.minX, to: bounds.maxX, by: ShapeView.stripeWidth) {
            let stripeRect = CGRect(
                x: offsetX,
                y: bounds.minY,
                width: ShapeView.stripeWidth,
                height: bounds.height
            )
            let stripe = UIBezierPath(rect: stripeRect)
            lastColor.setFill()
            stripe.fill()
            lastColor = lastColor == color ? UIColor.clear : color
            stripe.close()
        }
        color.setStroke()
        path.stroke()
    }
    
    private func drawDiamond(_ path: UIBezierPath) {
        path.move(to: CGPoint(x: bounds.minX + ShapeView.lineWidth, y: bounds.midY))
        path.addLine(to: CGPoint(x: bounds.midX, y: bounds.minY + ShapeView.lineWidth))
        path.addLine(to: CGPoint(x: bounds.maxX - ShapeView.lineWidth, y: bounds.midY))
        path.addLine(to: CGPoint(x: bounds.midX, y: bounds.maxY - ShapeView.lineWidth))
    }
    
    private func drawStadium(_ path: UIBezierPath) {
        let leftCenter = CGPoint(x: bounds.origin.x + bounds.midY, y: bounds.midY)
        let rightCenter = CGPoint(x: bounds.maxX - bounds.midY, y: bounds.midY)
        let radius = bounds.midY - (2 * ShapeView.lineWidth)
        path.addArc(withCenter: leftCenter, radius: radius, startAngle: 3 * CGFloat.pi / 2, endAngle: CGFloat.pi / 2, clockwise: false)
        path.addArc(withCenter: rightCenter, radius: radius, startAngle: CGFloat.pi / 2, endAngle: 3 * CGFloat.pi / 2, clockwise: false)
        path.close()
    }
}
