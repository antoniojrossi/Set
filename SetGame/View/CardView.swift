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
    private let cardBackgroundColor = #colorLiteral(red: 1, green: 0.9737340009, blue: 0.9157413435, alpha: 1)
    private var shapeHeight: CGFloat { return bounds.height * Ratios.shapeHeightRatio }
    private var shapeWidth: CGFloat { return bounds.width * Ratios.shapeWidthRatio }
    private var shapeMarginHeight: CGFloat { return bounds.height * Ratios.shapeMarginRatio }
    private var shadowOffset: CGFloat = 1.5
    private var cardCornerRadius: CGFloat { return bounds.width * Ratios.cardCornerRadiusRatio }
    private var totalShapesHeight: CGFloat {
        return (CGFloat(shapeViews.count) * shapeHeight) + (CGFloat(shapeViews.count - 1) * shapeMarginHeight)
    }
    
    var borderColor = UIColor.lightGray { didSet { setNeedsDisplay() } }
    var borderWidth: CGFloat = 1.0 { didSet { setNeedsDisplay() } }
    var numberOfShapes: Int = 3 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var shapeColor: UIColor = UIColor.purple { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var shading: ShapeView.Shading = .striped { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var shape: ShapeView.Shape = .squiggle { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var facedUp: Bool = true { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var showShadow: Bool = true { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    override var description: String {
        return "\(super.description) [\(numberOfShapes) \(shading) \(shapeColor) \(shape)]"
    }
    
    private lazy var shapeViews: [ShapeView] = {
        (0..<numberOfShapes).map{ _ in createShapeView() }
    }()
    
    private var shadowPath: UIBezierPath = UIBezierPath()
    
    convenience init(tapGestureRecognizer: UITapGestureRecognizer,
                     numberOfShapes: Int,
                     shapeColor: UIColor,
                     shape: ShapeView.Shape,
                     shading: ShapeView.Shading,
                     facedUp: Bool,
                     showShadow: Bool) {
        self.init(
            numberOfShapes: numberOfShapes,
            shapeColor: shapeColor,
            shape: shape,
            shading: shading,
            facedUp: facedUp,
            showShadow: showShadow
        )
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    convenience init(numberOfShapes: Int,
                     shapeColor: UIColor,
                     shape: ShapeView.Shape,
                     shading: ShapeView.Shading,
                     facedUp: Bool,
                     showShadow: Bool) {
        self.init(
            facedUp: facedUp,
            showShadow: showShadow
        )
        self.numberOfShapes = numberOfShapes
        self.shapeColor = shapeColor
        self.shape = shape
        self.shading = shading
    }
    
    convenience init(facedUp: Bool,
                     showShadow: Bool) {
        self.init()
        self.facedUp = facedUp
        self.showShadow = showShadow
        self.isOpaque = false
    }
    
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
        if facedUp {
            for (index, shapeView) in shapeViews.enumerated() {
                let distanceBetweenShapes = (CGFloat(index) * shapeHeight) + (CGFloat(index) * shapeMarginHeight)
                shapeView.frame = CGRect(
                    x: bounds.origin.x + ((bounds.width - shapeWidth) / 2),
                    y: bounds.origin.y + (bounds.height - totalShapesHeight) / CGFloat(2) + distanceBetweenShapes,
                    width: shapeWidth,
                    height: shapeHeight
                )
            }
        }
        if showShadow {
            drawCardShadow()
        }
    }
    
    override func draw(_ rect: CGRect) {
        drawCardBackground()
    }
    
    private func drawCardBackground() {
        let cardBack = UIBezierPath(roundedRect: bounds, cornerRadius: cardCornerRadius)
        cardBack.addClip()
        cardBack.lineWidth = borderWidth
        cardBackgroundColor.setFill()
        borderColor.setStroke()
        cardBack.fill()
        cardBack.stroke()
    }
    
    private func drawCardShadow() {
        shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cardCornerRadius)
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
        static let lineWidthRatio: CGFloat = 0.015
    }
}
