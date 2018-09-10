//
//  Board.swift
//  NaughtAndCrosses
//
//  Created by Emily Peregrine on 10/09/2018.
//  Copyright © 2018 Emily Peregrine. All rights reserved.
//

import Foundation

enum SquareState {
    case Naught
    case Cross
    case Empty
    
    var symbol: String {
        switch self {
        case .Cross:
            return "X"
        case .Naught:
            return "O"
        default:
            return " "
        }
    }
    
    func isTaken() -> Bool {
        return self != .Empty
    }
    
    mutating func select(forTurn turnType: TurnType) {
        switch turnType {
        case .Cross:
            self = .Cross
        case .Naught:
            self = .Naught
        }
    }
}

enum SquareIdentifier {
    case topLeft
    case topMiddle
    case topRight
    case middleLeft
    case middle
    case middleRight
    case bottomLeft
    case bottomMiddle
    case bottomRight
}

typealias SquareDict = [SquareIdentifier: SquareState]

class Board {
    let initSquares: SquareDict = [
        .topLeft: .Empty,
        .topMiddle: .Empty,
        .topRight: .Empty,
        .middleLeft: .Empty,
        .middle: .Empty,
        .middleRight: .Empty,
        .bottomLeft: .Empty,
        .bottomMiddle: .Empty,
        .bottomRight: .Empty,
    ]
    
    lazy var squares: SquareDict = initSquares
    
    func getSquareBy(identifier id: SquareIdentifier) -> SquareState {
        return squares[id]!
    }
    
    //Selects a board slot and returns a boolean about whether the box could be check, will reutrn false if it was
    func selectSlot(at sqId: SquareIdentifier, for turnType: TurnType) -> Bool {
        var square = squares[sqId]!
        if (!square.isTaken()) {
            square.select(forTurn: turnType)
            squares.updateValue(square, forKey: sqId)
            return true
        } else {
            return false
        }
    }
    
    func reset() {
        squares = initSquares
    }
    
    func getState() -> GameState {
        //TODO: implement checks
        var allTaken = true
        
        for (_, sqState) in squares {
            if !sqState.isTaken() {
                allTaken = false
                break
            }
        }
        
        return allTaken ? .draw : .running
    }
}
