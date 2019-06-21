//
//  Card.swift
//  SetGame
//
//  Created by Antonio J Rossi on 18/06/2019.
//  Copyright © 2019 Antonio J Rossi. All rights reserved.
//

import Foundation

struct Card: CustomStringConvertible {

    enum NumberOfShapes: Int {
        case one = 1
        case two
        case three
    }

    enum Shape {
        case diamond
        case squiggle
        case stadium
    }
    
    enum Shading {
        case solid
        case striped
        case open
    }
    
    enum Color {
        case red
        case green
        case purple
    }
    
    let numberOfShapes: NumberOfShapes
    let shape: Shape
    let shading: Shading
    let color: Color
    
    var description: String {
        return "\(numberOfShapes) \(shading) \(color) \(shape)"
    }
}
