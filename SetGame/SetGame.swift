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
    var isThereAMatch: Bool {
        get {
            guard selectedCards.count >= maxNumberOfSelectedCards else {
                return false
            }

            // TODO: find a more elegant way to do this. Add method in card??
            let matchByNumberOfShapes = selectedCards.map{card in card.numberOfShapes}.dropFirst().reduce(true){match, numberOfShapes in
                match && numberOfShapes == selectedCards.first?.numberOfShapes
            }
            let matchByShape = selectedCards.map{card in card.shape}.dropFirst().reduce(true){match, shape in
                match && shape == selectedCards.first?.shape
            }
            let matchByShading = selectedCards.map{card in card.shading}.dropFirst().reduce(true){match, shading in
                match && shading == selectedCards.first?.shading
            }
            let matchByColor = selectedCards.map{card in card.color}.dropFirst().reduce(true){match, color in
                match && color == selectedCards.first?.color
            }
            return matchByNumberOfShapes || matchByShape || matchByShading || matchByColor
        }
    }
    var canDealMoreCards: Bool {
        get {
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
            if isThereAMatch {
                replaceSelectedCardsWithNewOnes()
            }
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
    
    private mutating func replaceSelectedCardsWithNewOnes() {
        for selectedCard in selectedCards {
            if !deck.isEmpty, let index = faceUpCards.firstIndex(of: selectedCard) {
                faceUpCards.replace(at: index, with: deck.removeFirst())
            }
        }
    }
}
