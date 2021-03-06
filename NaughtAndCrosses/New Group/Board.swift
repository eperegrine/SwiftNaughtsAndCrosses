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
    
    var gameState: GameState {
        if self == .Empty {
            return .running
        } else {
            return self == .Cross ? .crossWon : .naughtWon
        }
    }
    
    mutating func select(forTurn turnType: TurnType) {
        switch turnType {
        case .Cross:
            self = .Cross
        case .Naught:
            self = .Naught
        }
    }
    
    static func CheckLine(_ squares: [SquareState]) -> Bool {
        let amt = squares.count
        if (amt <= 1) {
            return true
        } else {
            let first = squares.first!
            if first.isTaken() {
                var allMatch = true
                for sq in squares {
                    if sq != first {
                        allMatch = false
                        break
                    }
                }
                return allMatch
            } else { return false }
        }
    }
    
    static func CheckLine(_ squares: SquareState...) -> Bool {
        return CheckLine(squares)
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
    
    func getSquaresWith(identifiers: SquareIdentifier...) -> [SquareState] {
        var squareList: [SquareState] = []
        for id in identifiers {
            squareList.append(getSquareBy(identifier: id))
        }
        return squareList
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
        
        //Top Line
        if (SquareState.CheckLine(getSquaresWith(identifiers: .topLeft, .topMiddle, .topRight))) {
            return getSquareBy(identifier: .topLeft).gameState
        }
        //Horizontal Middle
        if (SquareState.CheckLine(getSquaresWith(identifiers: .middleLeft, .middle, .middleRight))) {
            return getSquareBy(identifier: .middleLeft).gameState
        }
        //Bottom
        if (SquareState.CheckLine(getSquaresWith(identifiers: .bottomLeft, .bottomMiddle, .bottomRight))) {
            return getSquareBy(identifier: .bottomLeft).gameState
        }
        //Left
        if (SquareState.CheckLine(getSquaresWith(identifiers: .topLeft, .middleLeft, .bottomLeft))) {
            return getSquareBy(identifier: .topLeft).gameState
        }
        //Vertical Middle
        if (SquareState.CheckLine(getSquaresWith(identifiers: .topMiddle, .middle, .bottomMiddle))) {
            return getSquareBy(identifier: .topMiddle).gameState
        }
        //Right
        if (SquareState.CheckLine(getSquaresWith(identifiers: .topRight, .middleRight, .bottomRight))) {
            return getSquareBy(identifier: .topRight).gameState
        }
        //LTR Diagonal
        if (SquareState.CheckLine(getSquaresWith(identifiers: .topLeft, .middle, .bottomRight))) {
            return getSquareBy(identifier: .topLeft).gameState
        }
        //RTL Diagonal
        if (SquareState.CheckLine(getSquaresWith(identifiers: .topRight, .middle, .bottomLeft))) {
            return getSquareBy(identifier: .topRight).gameState
        }
        
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
