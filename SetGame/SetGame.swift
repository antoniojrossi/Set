//
//  SetGame.swift
//  SetGame
//
//  Created by Antonio J Rossi on 18/06/2019.
//  Copyright © 2019 Antonio J Rossi. All rights reserved.
//

import Foundation

struct SetGame {
    private let initialNumberOfFaceUpCards = 12
    private var deck: [Card]
    private(set) var faceUpCards: [Card]
    
    init() {
        deck = Array<Card>()
        faceUpCards = Array<Card>()
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
        deck.removeLast(initialNumberOfFaceUpCards)
    }
}