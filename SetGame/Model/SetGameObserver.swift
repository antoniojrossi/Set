//
//  SetGameObserver.swift
//  SetGame
//
//  Created by Antonio J Rossi on 08/08/2019.
//  Copyright © 2019 Antonio J Rossi. All rights reserved.
//

import Foundation

protocol SetGameObserver {
    func thrownAwayCard(_ card: Card)
    func mismatch(_ cards: Set<Card>)
}
