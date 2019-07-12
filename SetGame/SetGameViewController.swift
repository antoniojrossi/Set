//
//  ViewController.swift
//  SetGame
//
//  Created by Antonio J Rossi on 18/06/2019.
//  Copyright © 2019 Antonio J Rossi. All rights reserved.
//

import UIKit

class SetGameViewController: UIViewController {
    private let cardSymbolGreen = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    private let cardSymbolPurple = #colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1)
    private let cardSymbolRed = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    private let selectedCardButtonBorderWidth = CGFloat(3.0)
    private let selectedCardButtonBorderColor = UIColor.blue.cgColor
    private let matchedCardButtonBorderColor = UIColor.green.cgColor
    private let mismatchedCardButtonBorderColor = UIColor.red.cgColor
    
    private(set) var game = SetGame(initialNumberOfFaceUpCards: 5, cardsPerDeal: 3)
    
    @IBOutlet weak var playingCardViews: GridView!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var dealCardsButton: UIButton!
    @IBAction private func newGame(_ sender: UIButton) {
        game = SetGame(initialNumberOfFaceUpCards: 5, cardsPerDeal: 3)
        updateViewFromModel()
    }
    @IBAction private func dealCards(_ sender: UIButton) {
        game.dealCards()
        updateViewFromModel()
    }
    
    override func viewDidLoad() {
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        playingCardViews.removeSubviews()
        dealCardsButton.isEnabled = game.canDealMoreCards
        scoreLabel.text = "Score: \(game.score)"
        for card in game.faceUpCards {
            let cardView = CardView()
            cardView.numberOfShapes = card.numberOfShapes.rawValue
            cardView.shapeColor = uiColorFor(card.color)
            cardView.shape = viewShape(for: card.shape)
            cardView.shading = viewShading(for: card.shading)
            cardView.isOpaque = false
            playingCardViews.addSubview(cardView)
        }
    }
    
    private func uiColorFor(_ color: Card.Color) -> UIColor {
        switch color {
        case .green: return cardSymbolGreen
        case .purple: return cardSymbolPurple
        case .red: return cardSymbolRed
        }
    }
    
    private func viewShape(for cardShape: Card.Shape) -> ShapeView.Shape {
        switch cardShape {
        case .diamond: return ShapeView.Shape.diamond
        case .squiggle: return ShapeView.Shape.squiggle
        case .stadium: return ShapeView.Shape.stadium
        }
    }
    
    private func viewShading(for cardShading: Card.Shading) -> ShapeView.Shading {
        switch cardShading {
        case .open: return ShapeView.Shading.open
        case .solid: return ShapeView.Shading.solid
        case .striped: return ShapeView.Shading.striped
        }
    }
}
