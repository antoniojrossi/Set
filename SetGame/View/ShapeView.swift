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
    
    // TODO: Seguramente haya que calcular este valor con proporción al tamaño de la carta
    lazy var lineWidth: CGFloat = bounds.width * Ratios.lineWidthRatio
    lazy var stripeWidth: CGFloat = bounds.width * Ratios.stripeWidth
    
    var color: UIColor = UIColor.black
    var shading: Shading = .open
    
    func applyShading(to path: UIBezierPath) {
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
        path.lineWidth = lineWidth
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
        for offsetX in stride(from: bounds.minX, to: bounds.maxX, by: stripeWidth) {
            let stripeRect = CGRect(
                x: offsetX,
                y: bounds.minY,
                width: stripeWidth,
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
}

extension ShapeView {
    private struct Ratios {
        static let lineWidthRatio: CGFloat = 0.01
        static let stripeWidth: CGFloat = 0.05
    }
}
