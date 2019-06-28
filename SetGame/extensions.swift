//
//  extensions.swift
//  SetGame
//
//  Created by Antonio J Rossi on 27/06/2019.
//  Copyright © 2019 Antonio J Rossi. All rights reserved.
//

import Foundation

extension Array {
    mutating func replace(at index: Int, with newElement: Element) {
        self.remove(at: index)
        self.insert(newElement, at: index)
    }
}

extension Array where Element: Equatable {
    func ocurrencesOf(_ element: Element) -> Int {
        return reduce(0){numberOfOcurrences, currentElement in
            return currentElement == element ? numberOfOcurrences + 1 : numberOfOcurrences
        }
    }
}
