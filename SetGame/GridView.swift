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
    var gridViewAspectRatio: (height: CGFloat, width: CGFloat) = (height: 8, width: 5)
    private var numberOfColumns: Int { return gridDimensions().columns }
    private var numberOfRows: Int { return gridDimensions().rows }
    
    override func layoutSubviews() {
        let gridWidth = bounds.width / CGFloat(numberOfColumns)
        let gridHeight = bounds.height / CGFloat(numberOfRows)
        let horizontalDelta = gridWidth < gridHeight ? gridWidth * Ratios.distanceBetweenCardsRatio : 0
        let verticalDelta = gridWidth < gridHeight ? 0 : gridHeight * Ratios.distanceBetweenCardsRatio
        
        var viewWidth: CGFloat = 0.0
        var viewHeight: CGFloat = 0.0
        if gridHeight > gridWidth{
            viewWidth = gridWidth - horizontalDelta
            viewHeight = viewWidth * gridViewAspectRatio.height / gridViewAspectRatio.width
        } else {
            viewHeight = gridHeight - verticalDelta
            viewWidth = gridHeight * gridViewAspectRatio.width / gridViewAspectRatio.height
        }
        
        for (index, view) in subviews.enumerated() {
            let dx: CGFloat = ((gridWidth - viewWidth) / CGFloat(2)) + (CGFloat(index % numberOfColumns) * gridWidth)
            let dy: CGFloat = ((gridHeight - viewHeight) / CGFloat(2)) + (CGFloat(index / numberOfColumns) * gridHeight)
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
    
    private func gridDimensions() -> (columns: Int, rows: Int) {
        let desiredAspectRatio = gridViewAspectRatio.height / gridViewAspectRatio.width
        let normalizedAspectRatio = (bounds.height / bounds.width) * desiredAspectRatio
        let columns = sqrt(Double(subviews.count) / Double(normalizedAspectRatio))
        let rows = sqrt(Double(normalizedAspectRatio) * Double(subviews.count))
        
        var dimensions: [Int: (columns: Int, rows: Int)] = [:]
        dimensions[columns.ceil * rows.floor] = (columns: columns.ceil, rows: rows.floor)
        dimensions[columns.floor * rows.ceil] = (columns: columns.floor, rows: rows.ceil)
        dimensions[columns.ceil * rows.ceil] = (columns: columns.ceil, rows: rows.ceil)
        dimensions[columns.floor * rows.floor] = (columns: columns.floor, rows: rows.floor)

        return dimensions[dimensions.keys.filter{$0 >= subviews.count}.min()!]!
    }
}

extension GridView {
    private struct Ratios {
        static let distanceBetweenCardsRatio: CGFloat = 0.05
    }
}

extension Double {
    var ceil: Int {
        return Int(Darwin.ceil(self))
    }
    
    var floor: Int {
        return Int(Darwin.floor(self))
    }
}
