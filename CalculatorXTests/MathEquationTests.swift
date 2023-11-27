//
//  CalculatorXTests.swift
//  CalculatorXTests
//
//  Created by Luis Santander on 11/9/23.
//

import XCTest
@testable import CalculatorX


// NOTE: Every function must have the test prefix in order to run the test.

final class MathEquationTests: XCTestCase {

    func testAddition() throws {
        var mathEquation = MathEquation(lhs: .zero)
        mathEquation.lhs = 4
        mathEquation.operation = .add
        mathEquation.rhs = 4
        mathEquation.execute()
        
        let expectedResut = Decimal(8)
        
        
        // ?? if the option comes out to be nil will be inferred to become false
        //    since the fuction test takes
        XCTAssertTrue(mathEquation.result?.isEqual(to: expectedResut) ?? false)
    }
    
    func testSubtraction() throws {
        var mathEquation = MathEquation(lhs: .zero)
        mathEquation.lhs = 4
        mathEquation.operation = .subtract
        mathEquation.rhs = 4
        mathEquation.execute()
        
        let expectedResut = Decimal(0)
        
        
        // ?? if the option comes out to be nil will be inferred to become false
        //    since the fuction test takes
        XCTAssertTrue(mathEquation.result?.isEqual(to: expectedResut) ?? false)
    }
    
    func testMultiply() throws {
        var mathEquation = MathEquation(lhs: .zero)
        mathEquation.lhs = 4
        mathEquation.operation = .multiply
        mathEquation.rhs = 4
        mathEquation.execute()
        
        let expectedResut = Decimal(16)
        
        
        // ?? if the option comes out to be nil will be inferred to become false
        //    since the fuction test takes
        XCTAssertTrue(mathEquation.result?.isEqual(to: expectedResut) ?? false)
    }
    
    func testDivision() throws {
        var mathEquation = MathEquation(lhs: .zero)
        mathEquation.lhs = 4
        mathEquation.operation = .divide
        mathEquation.rhs = 4
        mathEquation.execute()
        
        let expectedResut = Decimal(1)
        
        
        // ?? if the option comes out to be nil will be inferred to become false
        //    since the fuction test takes
        XCTAssertTrue(mathEquation.result?.isEqual(to: expectedResut) ?? false)
    }
}
