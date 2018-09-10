//
//  Game.swift
//  NaughtAndCrosses
//
//  Created by Emily Peregrine on 10/09/2018.
//  Copyright © 2018 Emily Peregrine. All rights reserved.
//

import Foundation

public enum GameState {
    case running
    case crossWon
    case naughtWon
    
    var isOver: Bool {
        return self != .running
    }
}

public enum TurnType {
    case Naught
    case Cross
    
    var opposite: TurnType {
        return self == .Naught ? .Cross: .Naught
    }
    
    mutating func flip() {
        self = self.opposite
    }
}

public class Game {
    let board = Board()
    public private(set) var winState = GameState.running
    public private(set) var currentTurn = TurnType.Naught
    
    func selectSlot(at sqId: SquareIdentifier) {
        if (board.selectSlot(at: sqId, for: currentTurn)) {
            currentTurn.flip()
            checkState()
        } else {
            //TODO: handle slot currently used
        }
    }
    
    func checkState() {
        let boardState = board.getState()
        if boardState.isTaken() {
            winState = boardState == .Cross ? .crossWon : .naughtWon
        } else {
            winState = .running
        }
    }
    
    func reset() {
        board.reset()
        winState = .running
        currentTurn = .Naught
    }
}
