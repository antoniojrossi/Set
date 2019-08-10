//
//  ViewController.swift
//  SetGame
//
//  Created by Antonio J Rossi on 18/06/2019.
//  Copyright © 2019 Antonio J Rossi. All rights reserved.
//

import UIKit

class SetGameViewController: UIViewController, SetGameObserver {
    private let selectedCardButtonBorderWidth = CGFloat(5.0)
    private let selectedCardButtonBorderColor = UIColor.blue.cgColor
    private let matchedCardButtonBorderColor = UIColor.green.cgColor
    private let mismatchedCardButtonBorderColor = UIColor.red.cgColor
    private let defaultCardBorderWidth: CGFloat = 1.0
    private let defaultCardBorderColor = UIColor.lightGray
    private(set) var game = SetGame(initialNumberOfFaceUpCards: 12, drawCardsBy: 3)
    
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
        game.addObserver(self)
        configureViews()
    }
    
    override func viewDidLoad() {
        playingCardsView.gridViewAspectRatio = (height: 8, width: 5)
        game.addObserver(self)
        configureViews()
    }
    
    private func configureViews() {
        playingCardsView.removeSubviews()
        deckView.cardsFaceUp = false
        deckView.viewGenerator = { CardView(facedUp: false, showShadow: false) }
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        updateScoreView()
        updateDeckView()
        updateFaceUpCardViews()
    }
    
    private func updateScoreView() {
        scoreLabel.text = "\(game.score)"
    }
    
    private func updateDeckView() {
        deckView.numberOfCards = game.numberOfCardsInDeck
    }
    
    private func updateFaceUpCardViews() {
        for (index, card) in game.faceUpCards.enumerated() {
            if let cardView = playingCardsView.view(at: index) as? CardView, card.representsTheSameCardAs(cardView) {
                updateSelectedCardsView(card, withView: cardView)
            } else {
                createCardView(for: card, andAddToPlayingCardsViewAt: index)
            }
        }
    }
    
    private func updateSelectedCardsView(_ card: Card, withView cardView: CardView) {
        if game.isCardSelected(card) {
            cardView.borderColor = UIColor(cgColor: selectedCardButtonBorderColor)
            cardView.borderWidth = selectedCardButtonBorderWidth
        } else {
            cardView.borderWidth = defaultCardBorderWidth
            cardView.borderColor = defaultCardBorderColor
        }
    }
    
    @objc func selectCard(recognizer: UITapGestureRecognizer) {
        if let cardView = recognizer.view as? CardView, let cardViewIndex = playingCardsView.index(of: cardView) {
            game.selectCard(at: cardViewIndex)
            updateViewFromModel()
        }
    }
    
    func thrownAwayCard(_ card: Card) {
        if let cardView = playingCardsView.subviews.first(where: {($0 as! CardView).representsTheSameCardAs(card)}) {
            playingCardsView.removeSubview(cardView)
        }
    }
    
    func mismatch(_ cards: Set<Card>) {
        for card in cards {
            if let cardView = playingCardsView.subviews.first(where: {($0 as! CardView).representsTheSameCardAs(card)}) as? CardView {
                cardView.borderColor = UIColor(cgColor: mismatchedCardButtonBorderColor)
                cardView.borderWidth = selectedCardButtonBorderWidth
            }
        }
    }
    
    private func createCardView(for card: Card, andAddToPlayingCardsViewAt index: Int) {
        let cardView = CardView(
            tapGestureRecognizer: UITapGestureRecognizer(target: self, action: #selector(selectCard(recognizer:))),
            numberOfShapes: card.numberOfShapes,
            shapeColor: card.color,
            shape: card.shape,
            shading: card.shading,
            facedUp: true,
            showShadow: false
        )
        playingCardsView.addSubview(cardView, at: index)
    }
}
