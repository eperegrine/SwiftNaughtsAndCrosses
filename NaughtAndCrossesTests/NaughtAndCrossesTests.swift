//
//  NaughtAndCrossesTests.swift
//  NaughtAndCrossesTests
//
//  Created by Emily Peregrine on 11/09/2018.
//  Copyright © 2018 Emily Peregrine. All rights reserved.
//

import XCTest
@testable import NaughtAndCrosses

class NaughtAndCrossesTests: XCTestCase {
    
    func testShouldMatchLines() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(SquareState.CheckLine(.Cross, .Cross, .Cross, .Cross, .Cross))
        XCTAssert(SquareState.CheckLine(.Cross, .Cross, .Cross))
        XCTAssert(SquareState.CheckLine(.Naught, .Naught, .Naught))
        
    }
    
    func testShouldNotMatchEmptyLines() {
        XCTAssert(!SquareState.CheckLine(.Empty, .Empty, .Empty))
    }
    
    func testShouldNotMatchIncorrectLines () {
        XCTAssert(!SquareState.CheckLine(.Cross, .Empty, .Empty))
        XCTAssert(!SquareState.CheckLine(.Naught, .Cross, .Naught))
        XCTAssert(!SquareState.CheckLine(.Naught, .Naught, .Cross))
    }
}
