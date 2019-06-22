//
//  ViewController.swift
//  SetGame
//
//  Created by Antonio J Rossi on 18/06/2019.
//  Copyright © 2019 Antonio J Rossi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let cardButtonCornerRadius = CGFloat(8.0)
    private let cardButtonBackgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    private let cardSymbolGreen = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
    private let cardSymbolPurple = #colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1)
    private let cardSymbolRed = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    private let diamodSymbol = "▲"
    private let squiggleSymbol = "●"
    private let stadiumSymbol = "■"
    private let solidAlpha = CGFloat(1)
    private let stripedAlpha = CGFloat(0.15)
    private let openStroke = 5
    private let solidStroke = -1
    private let invisibleCardButtonColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    private let selectedCardButtonBorderWidth = CGFloat(3.0)
    private let selectedCardButtonBorderColor = UIColor.blue.cgColor
    private let noBorderWidth = CGFloat(0.0)
    
    private(set) var game = SetGame(
        initialNumberOfFaceUpCards: 12,
        maxNumberOfFaceUpCards: 24,
        cardsPerDeal: 3
    )
    
    @IBOutlet private var faceUpCardButtons: [UIButton]!
    @IBOutlet weak var dealCardsButton: UIButton!
    @IBAction private func newGame(_ sender: UIButton) {
        game = SetGame(
            initialNumberOfFaceUpCards: 12,
            maxNumberOfFaceUpCards: 24,
            cardsPerDeal: 3
        )
        updateViewFromModel()
    }
    @IBAction private func dealCards(_ sender: UIButton) {
        game.dealCards()
        updateViewFromModel()
    }
    @IBAction private func selectCard(_ sender: UIButton) {
        if let selectedCardButtonIndex = faceUpCardButtons.firstIndex(of: sender) {
            game.selectCard(byIndex: selectedCardButtonIndex)
            updateViewFromModel()
        }
    }
    
    override func viewDidLoad() {
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        dealCardsButton.isEnabled = game.canDealMoreCards
        for index in faceUpCardButtons.indices {
            let cardButton = faceUpCardButtons[index]
            if game.faceUpCards.indices.contains(index) {
                updateCardUI(cardButton, with: game.faceUpCards[index])
            } else {
                updateCardUI(cardButton, with: nil)
            }
        }
    }
    
    private func updateSelectedCardsViewFromModel() {
        for index in game.faceUpCards.indices {
            if game.selectedCards.contains(game.faceUpCards[index]) {
                
            }
        }
    }
    
    private func updateCardUI(_ cardButton: UIButton, with card: Card?) {
        guard card != nil else {
            cardButton.setTitle(String(), for: UIControl.State.normal)
            cardButton.setAttributedTitle(NSAttributedString(), for: UIControl.State.normal)
            cardButton.backgroundColor = invisibleCardButtonColor
            cardButton.layer.borderWidth = noBorderWidth
            return
        }
        cardButton.backgroundColor = cardButtonBackgroundColor
        cardButton.layer.cornerRadius = cardButtonCornerRadius
        let numberOfShapes = card!.numberOfShapes.rawValue
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: uiColorFor(card!.color).withAlphaComponent(alphaFor(card!.shading)),
            .strokeWidth: strokeFor(card!.shading)
        ]
        let attributedText = NSAttributedString(string: String(repeating: symbolForShape(card!.shape), count: numberOfShapes) , attributes: attributes)
        cardButton.setAttributedTitle(attributedText, for: UIControl.State.normal)
        if game.isCardSelected(card!) {
            cardButton.layer.borderWidth = selectedCardButtonBorderWidth
            cardButton.layer.borderColor = selectedCardButtonBorderColor
        } else {
            cardButton.layer.borderWidth = noBorderWidth
        }
    }
    
    private func uiColorFor(_ color: Card.Color) -> UIColor {
        switch color {
        case .green: return cardSymbolGreen
        case .purple: return cardSymbolPurple
        case .red: return cardSymbolRed
        }
    }
    
    private func symbolForShape(_ shape: Card.Shape) -> String {
        switch shape {
        case .diamond: return diamodSymbol
        case .squiggle: return squiggleSymbol
        case .stadium: return stadiumSymbol
        }
    }
    
    private func alphaFor(_ shading: Card.Shading) -> CGFloat {
        switch shading {
        case .open, .solid: return solidAlpha
        case .striped: return stripedAlpha
        }
    }
    
    private func strokeFor(_ shading: Card.Shading) -> Int {
        switch shading {
        case .open: return openStroke
        case .solid, .striped: return solidStroke
        }
    }
}
