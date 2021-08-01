//
//  CouchbaseLiteExperimentsTests.swift
//  CouchbaseLiteExperimentsTests
//
//  Created by Gabriel Terwesten on 01.08.21.
//

import XCTest
import CouchbaseLiteSwift

class ArrayContainsTests: TestBase {

    func testContainsString()  {
        XCTAssertTrue(evalExpr(
            ArrayFunction.contains(
                Expression.array(["a"]),
                value: Expression.value("a")
            )
        ).boolean)
        
        XCTAssertFalse(evalExpr(
            ArrayFunction.contains(
                Expression.array(["a"]),
                value: Expression.value("b")
            )
        ).boolean)
    }
    
    func testContainsBoolean() {
        XCTAssertFalse(evalExpr(
            ArrayFunction.contains(
                Expression.array([false]),
                value: Expression.boolean(true)
            )
        ).boolean)
        
        // Fails
        XCTAssertTrue(evalExpr(
            ArrayFunction.contains(
                Expression.array([true]),
                value: Expression.boolean(true)
            )
        ).boolean)
    }

}
