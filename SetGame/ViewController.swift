//
//  ViewController.swift
//  SetGame
//
//  Created by Antonio J Rossi on 18/06/2019.
//  Copyright © 2019 Antonio J Rossi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private(set) var setGame = SetGame()
    
    @IBOutlet private var faceUpCards: [UIButton]!

    @IBAction private func newGame(_ sender: UIButton) {
    }
    
    @IBAction private func dealCards(_ sender: UIButton) {
    }
    
    @IBAction private func selectCard(_ sender: UIButton) {
        print("Card selected!")
    }
}
