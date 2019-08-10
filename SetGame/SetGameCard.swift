//
//  SetGameCard.swift
//  SetGame
//
//  Created by Antonio J Rossi on 10/08/2019.
//  Copyright © 2019 Antonio J Rossi. All rights reserved.
//

import Foundation

protocol SetGameCard {
    func isEquivalentTo(_ card: SetGameCard) -> Bool
}
