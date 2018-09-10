//
//  ViewController.swift
//  NaughtAndCrosses
//
//  Created by Emily Peregrine on 02/09/2018.
//  Copyright © 2018 Emily Peregrine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gameStateLabel: UILabel!
    
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var topMiddleButton: UIButton!
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var middleLeftButton: UIButton!
    @IBOutlet weak var middleButton: UIButton!
    @IBOutlet weak var middleRightButton: UIButton!
    @IBOutlet weak var bottomLeftButton: UIButton!
    @IBOutlet weak var bottomMiddleButton: UIButton!
    @IBOutlet weak var bottomRightButton: UIButton!
    
    let game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        switch sender {
            case topLeftButton: selectSquare(identifier: .topLeft)
            case topMiddleButton: selectSquare(identifier: .topMiddle)
            case topRightButton: selectSquare(identifier: .topRight)
            case middleLeftButton: selectSquare(identifier: .middleLeft)
            case middleButton: selectSquare(identifier: .middle)
            case middleRightButton: selectSquare(identifier: .middleRight)
            case bottomLeftButton: selectSquare(identifier: .bottomLeft)
            case bottomMiddleButton: selectSquare(identifier: .bottomMiddle)
            case bottomRightButton: selectSquare(identifier: .bottomRight)
        default:
            print("error out")
        }
    }
    
    @IBAction func resetGame(_ sender: Any) {
        game.reset()
        updateView()
    }
    
    
    public func selectSquare(identifier: SquareIdentifier) {
        game.selectSlot(at: identifier)
        updateView()
    }
    
    func updateView() {
        if (game.state.isOver) {
            var gameLabelText = ""
            if (game.state == .draw) {
                gameLabelText = "It's a Draw!"
            } else {
                gameLabelText = "\(game.state == GameState.crossWon ? "Cross" : "Naught") Won"
            }
            gameStateLabel.text = gameLabelText
        } else {
            gameStateLabel.text = "\(game.currentTurn.symbol)'s Turn"
        }
        
        topLeftButton.setTitle(game.board.getSquareBy(identifier: .topLeft).symbol, for: .normal)
        topMiddleButton.setTitle(game.board.getSquareBy(identifier: .topMiddle).symbol, for: .normal)
        topRightButton.setTitle(game.board.getSquareBy(identifier: .topRight).symbol, for: .normal)
        middleLeftButton.setTitle(game.board.getSquareBy(identifier: .middleLeft).symbol, for: .normal)
        middleButton.setTitle(game.board.getSquareBy(identifier: .middle).symbol, for: .normal)
        middleRightButton.setTitle(game.board.getSquareBy(identifier: .middleRight).symbol, for: .normal)
        bottomLeftButton.setTitle(game.board.getSquareBy(identifier: .bottomLeft).symbol, for: .normal)
        bottomMiddleButton.setTitle(game.board.getSquareBy(identifier: .bottomMiddle).symbol, for: .normal)
        bottomRightButton.setTitle(game.board.getSquareBy(identifier: .bottomRight).symbol, for: .normal)
    }

}

