//
//  GridView.swift
//  SetGame
//
//  Created by Antonio J Rossi on 10/07/2019.
//  Copyright © 2019 Antonio J Rossi. All rights reserved.
//

import UIKit

@IBDesignable
class GridView: UIView {
    override func layoutSubviews() {
        let gridWidth = bounds.width / CGFloat(subviews.count)
        let gridHeight = bounds.height
        let horizontalDelta = gridWidth < gridHeight ? gridWidth * Ratios.distanceBetweenCardsRatio : 0
        let verticalDelta = gridWidth < gridHeight ? 0 : gridHeight * Ratios.distanceBetweenCardsRatio
        
        var viewWidth: CGFloat = 0.0
        var viewHeight: CGFloat = 0.0
        if gridHeight > gridWidth{
            viewWidth = gridWidth - horizontalDelta
            viewHeight = viewWidth * 8 / 5
        } else {
            viewHeight = gridHeight - verticalDelta
            viewWidth = gridHeight * 5 / 8
        }
        
        for (index, view) in subviews.enumerated() {
            let dx: CGFloat = ((gridWidth - viewWidth) / CGFloat(2)) + (CGFloat(index) * gridWidth)
            let dy: CGFloat = ((gridHeight - viewHeight) / CGFloat(2))
            view.frame = CGRect(
                x: bounds.origin.x + dx,
                y: bounds.origin.y + dy,
                width: viewWidth,
                height: viewHeight
            )
        }
    }
    
    func removeSubviews() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }
}

extension GridView {
    private struct Ratios {
        static let distanceBetweenCardsRatio: CGFloat = 0.05
    }
}
