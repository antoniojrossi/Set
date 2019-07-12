//
//  SetCardView.swift
//  SetGame
//
//  Created by Antonio J Rossi on 07/07/2019.
//  Copyright © 2019 Antonio J Rossi. All rights reserved.
//
import UIKit

@IBDesignable
class CardView: UIView {
    private let cardBackgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
    private let cardBorderColor = UIColor.lightGray
    private var shapeHeight: CGFloat { return bounds.height * Ratios.shapeHeightRatio }
    private var shapeWidth: CGFloat { return bounds.width * Ratios.shapeWidthRatio }
    private var shapeMarginHeight: CGFloat { return bounds.height * Ratios.shapeMarginRatio }
    private var shadowOffset: CGFloat { return bounds.width * Ratios.shadowOffsetRatio }
    private var cardLineWidth: CGFloat {return bounds.width * Ratios.lineWidthRatio}
    private var cardCornerRadius: CGFloat { return bounds.width * Ratios.cardCornerRadiusRatio }
    private var totalShapesHeight: CGFloat {
        return (CGFloat(shapeViews.count) * shapeHeight) + (CGFloat(shapeViews.count - 1) * shapeMarginHeight)
    }
    
    var numberOfShapes: Int = 3 {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    var shapeColor: UIColor = UIColor.purple
    var shading: ShapeView.Shading = .striped
    var shape: ShapeView.Shape = .squiggle
    
    private lazy var shapeViews: [ShapeView] = {
        (0..<numberOfShapes).map{ _ in createShapeView() }
    }()
    
    private func createShapeView() -> ShapeView {
        var shapeView = ShapeView()
        switch shape {
        case .stadium:
            shapeView = StadiumView()
        case .squiggle:
            shapeView = SquiggleView()
        case .diamond:
            shapeView = DiamondView()
        }
        addSubview(configure(shapeView))
        return shapeView
    }
    
    private func configure(_ shapeView: ShapeView) -> ShapeView {
        shapeView.isOpaque = true
        shapeView.backgroundColor = UIColor.clear
        shapeView.color = shapeColor
        shapeView.shading = shading
        return shapeView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for (index, shapeView) in shapeViews.enumerated() {
            // ¿UIStackView + Autolayout?
            let distanceBetweenShapes = (CGFloat(index) * shapeHeight) + (CGFloat(index) * shapeMarginHeight)
            shapeView.frame = CGRect(
                x: bounds.origin.x + ((bounds.width - shapeWidth) / 2),
                y: bounds.origin.y + (bounds.height - totalShapesHeight) / CGFloat(2) + distanceBetweenShapes,
                width: shapeWidth,
                height: shapeHeight
            )
        }
    }
    
    override func draw(_ rect: CGRect) {
        drawCardBack()
    }
    
    private func drawCardBack() {
        let cardBack = UIBezierPath(roundedRect: bounds, cornerRadius: cardCornerRadius)
        cardBack.addClip()
        cardBack.lineWidth = cardLineWidth
        cardBackgroundColor.setFill()
        cardBorderColor.setStroke()
        cardBack.fill()
        cardBack.stroke()
        //drawCardShadow(cardBack)
    }
    
    private func drawCardShadow(_ cardBack: UIBezierPath) {
        let shadowPath = cardBack
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: shadowOffset, height: shadowOffset)
        layer.shadowOpacity = 0.5
        layer.shadowPath = shadowPath.cgPath
    }
}

extension CardView {
    private struct Ratios {
        static let cardCornerRadiusRatio: CGFloat = 0.08
        static let shapeWidthRatio: CGFloat = 0.75
        static let shapeHeightRatio: CGFloat = 0.2
        static let shapeMarginRatio: CGFloat = 0.05
        static let shadowOffsetRatio: CGFloat = 0.01
        static let lineWidthRatio: CGFloat = 0.015
    }
}
