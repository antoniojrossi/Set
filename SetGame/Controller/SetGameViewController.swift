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
    private(set) var game = SetGame(initialNumberOfFaceUpCards: 12, drawCardsBy: 3)
    private var cardForCarView: [CardView: Card] = [CardView: Card]()
    
    @IBOutlet weak var playingCardsView: GridView!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet weak var deckView: DeckView!
    
    @IBAction func drawCards(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            if game.canDealMoreCards {
                game.drawCards()
                updateViewFromModel()
            }
        default: break
        }
    }
    
    @IBAction func newGame(_ sender: UITapGestureRecognizer) {
        game = SetGame(initialNumberOfFaceUpCards: 12, drawCardsBy: 3)
        configureViews()
    }
    
    override func viewDidLoad() {
        playingCardsView.gridViewAspectRatio = (height: 8, width: 5)
        configureViews()
    }
    
    private func configureViews() {
        playingCardsView.removeSubviews()
        cardForCarView.removeAll()
        deckView.cardsFaceUp = false
        deckView.viewGenerator = { CardView(facedUp: false, showShadow: false) }
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        scoreLabel.text = "\(game.score)"
        deckView.numberOfCards = game.numberOfCardsInDeck
        for (index, card) in game.faceUpCards.enumerated() {
            if let cardView = playingCardsView.view(at: index) as? CardView {
                if cardForCarView[cardView] == card {
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
                } else {
                    createCardView(for: card, andAddToPlayingCardsViewAt: index)
                }
            } else {
                createCardView(for: card, andAddToPlayingCardsViewAt: index)
            }
        }
    }
    
    @objc func selectCard(recognizer: UITapGestureRecognizer) {
        if let cardView = recognizer.view as? CardView, let cardViewIndex = playingCardsView.index(of: cardView) {
            game.selectCard(at: cardViewIndex)
            updateViewFromModel()
        }
    }
    
    private func createCardView(for card: Card, andAddToPlayingCardsViewAt index: Int) {
        let cardView = CardView(
            tapGestureRecognizer: UITapGestureRecognizer(target: self, action: #selector(selectCard(recognizer:))),
            numberOfShapes: card.numberOfShapes.rawValue,
            shapeColor: uiColorFor(card.color),
            shape: viewShape(for: card.shape),
            shading: viewShading(for: card.shading),
            facedUp: true,
            showShadow: true
        )
        cardForCarView[cardView] = card
        playingCardsView.addSubview(cardView, at: index)
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
