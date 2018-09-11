//
//  ViewController.swift
//  NaughtAndCrosses
//
//  Created by Emily Peregrine on 02/09/2018.
//  Copyright © 2018 Emily Peregrine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var baseView: UIView!
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
    
    let runningColour = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    let runningTextColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    let drawColour = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    let drawTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    let wonColour = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    let wonTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkGameState()
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        if (game.state.isOver) {
            resetGame(self)
        } else {
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
       
    }
    
    @IBAction func resetGame(_ sender: Any) {
        game.reset()
        checkGameState()
    }
    
    
    public func selectSquare(identifier: SquareIdentifier) {
        game.selectSlot(at: identifier)
        checkGameState()
    }
    
    func checkGameState() {
        if (game.state.isOver) {
            var gameLabelText = ""
            if (game.state == .draw) {
                gameLabelText = "It's a Draw!"
                baseView.backgroundColor = drawColour
                gameStateLabel.textColor = drawTextColor
            } else {
                baseView.backgroundColor = wonColour
                gameStateLabel.textColor = wonTextColor
                gameLabelText = "\(game.state == GameState.crossWon ? "Cross" : "Naught") Won"
            }
            gameStateLabel.text = gameLabelText
        } else {
            gameStateLabel.text = "\(game.currentTurn.symbol)'s Turn"
            baseView.backgroundColor = runningColour
            gameStateLabel.textColor = runningTextColor
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

