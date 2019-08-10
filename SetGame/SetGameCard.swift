//
//  SetGameCard.swift
//  SetGame
//
//  Created by Antonio J Rossi on 10/08/2019.
//  Copyright © 2019 Antonio J Rossi. All rights reserved.
//

import Foundation

enum SetGameCard {
    enum NumberOfShapes: Int {
        case one = 1
        case two
        case three
    }
    
    enum Shape: Int {
        case diamond
        case squiggle
        case stadium
    }
    
    enum Shading: Int {
        case solid
        case striped
        case open
    }
    
    enum Color: Int {
        case red
        case green
        case purple
    }
}

protocol SetGameCardEntity {
    var numberOfShapes: SetGameCard.NumberOfShapes { get }
    var shape: SetGameCard.Shape { get }
    var shading: SetGameCard.Shading { get }
    var color: SetGameCard.Color { get }
    func representsTheSameCardAs(_ card: SetGameCardEntity) -> Bool
}

extension SetGameCardEntity {
    func representsTheSameCardAs(_ card: SetGameCardEntity) -> Bool {
        return numberOfShapes == card.numberOfShapes &&
            shape == card.shape &&
            shading == card.shading &&
            color == card.color
    }
}
