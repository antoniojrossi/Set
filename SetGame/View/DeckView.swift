//
//  DeckView.swift
//  SetGame
//
//  Created by Antonio J Rossi on 22/07/2019.
//  Copyright © 2019 Antonio J Rossi. All rights reserved.
//

import UIKit

@IBDesignable
class DeckView: UIView {
    
    private struct Constants {
        static let randomRotationDuration: Double = 0.18
        static let minRotationAngle: CGFloat = -0.1
        static let maxRotationAngle: CGFloat = 0.1
    }
    
    @IBInspectable
    var numberOfCards: Int = 0 {
        didSet {
            if numberOfCards != oldValue {
                if numberOfCards > subviews.count {
                    for _ in 0..<(numberOfCards - subviews.count) {
                        addSubview(viewGenerator())
                    }
                } else {
                    for _ in 0..<(subviews.count - numberOfCards) {
                        subviews.last?.removeFromSuperview()
                    }
                }
                setNeedsLayout()
            }
        }
    }
    @IBInspectable
    var cardsFaceUp: Bool = false
    var viewGenerator: () -> UIView = UIView.init
    
    override func layoutSubviews() {
        for view in subviews {
            view.frame = CGRect(
                x: bounds.origin.x,
                y: bounds.origin.y,
                width: bounds.width,
                height: bounds.height
            )
            UIView.transition(
                with: view,
                duration: Constants.randomRotationDuration,
                options: [.allowUserInteraction, .curveEaseInOut],
                animations: {
                    let randomAngle = CGFloat.arc4random(
                        min: Constants.minRotationAngle,
                        max: Constants.maxRotationAngle)
                    view.transform = CGAffineTransform.identity.rotated(by: randomAngle)
                }
            )
        }
    }

}
