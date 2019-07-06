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
    private let pointsPerMatch = 3
    private let penalizationPerMismatch = -5
    private let penalizationPerDeselection = -1
    private let initialNumberOfFaceUpCards: Int
    private let cardsPerDeal: Int
    private var deck: [Card]
    private(set) var faceUpCards: [Card]
    private(set) var selectedCards: Set<Card>
    private(set) var score = 0
    var isThereAMatch: Bool {
        get {
            guard selectedCards.count >= maxNumberOfSelectedCards else {
                return false
            }
            let cards = Array(selectedCards)
            let matchByNumberOfShapes = isAMatchOf(cards[0], cards[1], cards[2], by: {$0.numberOfShapes.rawValue})
            let matchByShape = isAMatchOf(cards[0], cards[1], cards[2], by: {$0.shape.rawValue})
            let matchByShading = isAMatchOf(cards[0], cards[1], cards[2], by: {$0.shading.rawValue})
            let matchByColor = isAMatchOf(cards[0], cards[1], cards[2], by: {$0.color.rawValue})
            return [matchByNumberOfShapes, matchByShape, matchByShading, matchByColor].reduce(true){$0 && $1}
        }
    }
    var isThereAMismatch: Bool {
        get {
            guard selectedCards.count >= maxNumberOfSelectedCards else {
                return false
            }

            return !isThereAMatch
        }
    }
    var canDealMoreCards: Bool {
        get {
            return !deck.isEmpty
        }
    }
    
    init(initialNumberOfFaceUpCards: Int, cardsPerDeal: Int) {
        self.initialNumberOfFaceUpCards = initialNumberOfFaceUpCards
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
        if selectedCards.contains(selectedCard), selectedCards.count < maxNumberOfSelectedCards {
            score = max(0, score + penalizationPerDeselection)
            selectedCards.remove(selectedCard)
        } else {
            if selectedCards.count >= maxNumberOfSelectedCards, !selectedCards.contains(selectedCard) {
                if isThereAMatch {
                    score += pointsPerMatch
                    replaceSelectedCardsWithNewOnes()
                } else {
                    score = max(0, score + penalizationPerMismatch)
                }
                selectedCards.removeAll()
            }
            selectedCards.insert(selectedCard)
        }
    }
    
    mutating func dealCards() {
        for _ in (0..<cardsPerDeal) {
            if let dealedCard = deck.first {
                faceUpCards.append(dealedCard)
                deck.removeFirst()
            }
        }
    }
    
    private mutating func replaceSelectedCardsWithNewOnes() {
        for selectedCard in selectedCards {
            if let index = faceUpCards.firstIndex(of: selectedCard) {
                if !deck.isEmpty {
                    faceUpCards.replace(at: index, with: deck.removeFirst())
                } else {
                    faceUpCards.remove(at: index)
                }
            }
        }
    }
    
    private func isAMatchOf(_ card1: Card, _ card2: Card, _ card3: Card, by feature: ((Card) -> Int)) -> Bool {
        return (feature(card1) == feature(card2) && feature(card2) == feature(card3)) ||
               ((feature(card1) != feature(card2)) && (feature(card2) != feature(card3)) && (feature(card1) != feature(card3)))
    }
}
