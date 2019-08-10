//
//  Card.swift
//  SetGame
//
//  Created by Antonio J Rossi on 18/06/2019.
//  Copyright © 2019 Antonio J Rossi. All rights reserved.
//

import Foundation

struct Card: SetGameCardEntity, CustomStringConvertible, Hashable {
    let numberOfShapes: SetGameCard.NumberOfShapes
    let shape: SetGameCard.Shape
    let shading: SetGameCard.Shading
    let color: SetGameCard.Color
    
    var description: String {
        return "\(numberOfShapes) \(shading) \(color) \(shape)"
    }
}
