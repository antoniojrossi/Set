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
    private let selectedCardButtonBorderWidth = CGFloat(5.0)
    private let selectedCardButtonBorderColor = UIColor.blue.cgColor
    private let matchedCardButtonBorderColor = UIColor.green.cgColor
    private let mismatchedCardButtonBorderColor = UIColor.red.cgColor
    private let defaultCardBorderWidth: CGFloat = 1.0
    private(set) var game = SetGame(initialNumberOfFaceUpCards: 12, cardsPerDeal: 3)
    @IBOutlet weak var playingCardGridView: GridView!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var dealCardsButton: UIButton!
    private var cardViewIndices: [CardView: Int] = [:]
    
    @IBAction private func newGame(_ sender: UIButton) {
        game = SetGame(initialNumberOfFaceUpCards: 12, cardsPerDeal: 3)
        updateViewFromModel()
    }
    @IBAction private func drawCards(_ sender: UIButton) {
        game.drawCards()
        updateViewFromModel()
    }
    
    @IBAction func randomizeFaceUpCards(_ sender: UIRotationGestureRecognizer) {
        switch sender.state {
        case .ended:
            game.randomizeFaceUpCards()
            updateViewFromModel()
        default: break
        }
    }
    
    override func viewDidLoad() {
        playingCardGridView.gridViewAspectRatio = (height: 8, width: 5)
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        playingCardGridView.removeSubviews()
        cardViewIndices = [:]
        dealCardsButton.isEnabled = game.canDealMoreCards
        scoreLabel.text = "Score: \(game.score)"
        for (index, card) in game.faceUpCards.enumerated() {
            let cardView = CardView()
            let tap = UITapGestureRecognizer(target: self, action: #selector(selectCard(recognizer:)))
            cardView.addGestureRecognizer(tap)
            cardView.numberOfShapes = card.numberOfShapes.rawValue
            cardView.shapeColor = uiColorFor(card.color)
            cardView.shape = viewShape(for: card.shape)
            cardView.shading = viewShading(for: card.shading)
            cardView.isOpaque = false
            if game.isCardSelected(card) {
                cardView.borderColor = UIColor(cgColor: selectedCardButtonBorderColor)
                cardView.borderWidth = selectedCardButtonBorderWidth
                if game.isThereAMatch {
                    cardView.borderColor = UIColor(cgColor: matchedCardButtonBorderColor)
                } else if game.isThereAMismatch {
                    cardView.borderColor = UIColor(cgColor: mismatchedCardButtonBorderColor)
                } else {
                    cardView.borderColor = UIColor(cgColor: selectedCardButtonBorderColor)
                }
            } else {
                cardView.borderWidth = defaultCardBorderWidth
            }
            cardViewIndices[cardView] = index
            playingCardGridView.addSubview(cardView)
        }
    }
    
    @objc func selectCard(recognizer: UITapGestureRecognizer) {
        if let cardView = recognizer.view as? CardView, let index = cardViewIndices[cardView] {
            game.selectCard(byIndex: index)
            updateViewFromModel()
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
