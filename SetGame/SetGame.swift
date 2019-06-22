//
//  SetGame.swift
//  SetGame
//
//  Created by Antonio J Rossi on 18/06/2019.
//  Copyright © 2019 Antonio J Rossi. All rights reserved.
//

import Foundation

struct SetGame {
    private let maxNumberOfSelectedCards = 3
    private let initialNumberOfFaceUpCards: Int
    private let maxNumberOfFaceUpCards: Int
    private let cardsPerDeal: Int
    private var deck: [Card]
    private(set) var faceUpCards: [Card]
    private(set) var selectedCards: Set<Card>
    var canDealMoreCards: Bool {
        get {
            print("faceUpCards.count: \(faceUpCards.count), maxNumberOfFaceUpCards: \(maxNumberOfFaceUpCards) ")
            print("faceUpCards.count >= maxNumberOfFaceUpCards: \(faceUpCards.count >= maxNumberOfFaceUpCards)")
            return !(deck.isEmpty || faceUpCards.count >= maxNumberOfFaceUpCards)
        }
    }
    
    init(initialNumberOfFaceUpCards: Int, maxNumberOfFaceUpCards: Int, cardsPerDeal: Int) {
        self.initialNumberOfFaceUpCards = initialNumberOfFaceUpCards
        self.maxNumberOfFaceUpCards = maxNumberOfFaceUpCards
        self.cardsPerDeal = cardsPerDeal
        deck = Array<Card>()
        faceUpCards = Array<Card>()
        selectedCards = Set<Card>()
        let numberOfShapes: [Card.NumberOfShapes] = [.one, .two, .three]
        let shapes: [Card.Shape] = [.diamond, .squiggle, .stadium]
        let shadings: [Card.Shading] = [.solid, .striped, .open]
        let colors: [Card.Color] = [.red, .green, .purple]
        // TODO: Refactor. extension of sequence??
        for numberOfShape in numberOfShapes {
            for shape in shapes {
                for shading in shadings {
                    for color in colors {
                        deck.append(Card(numberOfShapes: numberOfShape, shape: shape, shading: shading, color: color))
                    }
                }
            }
        }
        deck.shuffle()
        faceUpCards = Array(deck[0..<initialNumberOfFaceUpCards])
        deck.removeFirst(initialNumberOfFaceUpCards)
    }
    
    func isCardSelected(_ card: Card) -> Bool {
        return selectedCards.contains(card)
    }
    
    mutating func selectCard(byIndex index: Int) {
        guard faceUpCards.indices.contains(index) else {
            return
        }
        let selectedCard = faceUpCards[index]
        if selectedCards.count >= maxNumberOfSelectedCards, !selectedCards.contains(selectedCard) {
            selectedCards.removeAll()
        }
        selectedCards.insert(selectedCard)
    }
    
    mutating func dealCards() {
        for _ in (0..<cardsPerDeal) {
            if faceUpCards.count < maxNumberOfFaceUpCards, let dealedCard = deck.first {
                faceUpCards.append(dealedCard)
                deck.removeFirst()
            }
        }
    }
}
