//
//  MathInputController.swift
//  CalculatorX
//
//  Created by Luis Santander on 12/3/23.
//

import Foundation


// NOTES:
/**
 
 We don't want the Calculator Engine Accessing the Math Equation directly. We want to have
 a hierchy so we are going to implement a Layered Architecture pattern where the Calculator Engine interacts
 with the Math Input Controller and then the calculator engine.
 
 Sphagetti Code is when you by pass Architecture and start accessing methods directly down the heirchy which
 can cause a disaster to happen as the application scales.
 
 Heavy changes is considered refactoring. 
 
 */

struct MathInputController {
    
    // MARK: - Operand Editing Side
    
    enum OperandSide {
        case leftHandSide
        case rightHandSide
    }
    
    private var operandSide = OperandSide.leftHandSide
    
    // MARK: - Math Equation
    
    // NOTES: -
    /**
        what does private(set) mean? it means that it only allows MathInputController to set a new Math Equation within
         it's scope domain but it allows external code to access the math equation. basically its privatizes setting a new value for
          the math equation but allows public access in retrieving the value.
     */
    
    private(set) var mathEquation = MathEquation(lhs: .zero)
    
    // MARK: - LCD Display
    
    var lcdDisplayText = ""
    
    // MARK: - Initializer
    
    init() {
        lcdDisplayText = mathEquation.lhs.formatted()
    }
    
    // MARK: - Extra Functions
    
    mutating func negatePressed() {
        switch operandSide {
        case .leftHandSide:
            mathEquation.negateLeftHandSide()
            lcdDisplayText = mathEquation.lhs.formatted()
        case .rightHandSide:
            mathEquation.negateRightHandSide()
            lcdDisplayText = mathEquation.rhs?.formatted() ?? "Error"
        }
    }
    
    mutating func percentagePressed() {
        switch operandSide {
        case .leftHandSide:
            mathEquation.applyPercentageToLeftHandSide()
            lcdDisplayText = mathEquation.lhs.formatted()
        case .rightHandSide:
            mathEquation.applyPercentageToRightHandSide()
            lcdDisplayText = mathEquation.rhs?.formatted() ?? "Error"
        }
    }
    
    // MARK: - Operations
    
    mutating func addPressed() {
        mathEquation.operation = MathEquation.OperationType.add
        operandSide = .rightHandSide
    }
    
    mutating func minusPressed() {
        mathEquation.operation = MathEquation.OperationType.subtract
        operandSide = .rightHandSide
    }
    
    mutating func multiplyPressed() {
        mathEquation.operation = MathEquation.OperationType.multiply
        operandSide = .rightHandSide
    }
    
    mutating func dividePressed() {
        mathEquation.operation = MathEquation.OperationType.divide
        operandSide = .rightHandSide
    }
    
    mutating func execute() {
        mathEquation.execute()
        lcdDisplayText = mathEquation.result?.formatted() ?? "Error"
    }
    
    // MARK: - Number Input
    
    // TODO: - DECIMAL PRESSED
    mutating func decimalPressed() {
        
    }
    
    mutating func numberPressed(_ number: Int) {
        guard number >= -9, number <= 9 else { return }
        
        switch operandSide {
        case .leftHandSide:
            let tuple = appendNumber(number, toPreviousInput: mathEquation.lhs)
            mathEquation.lhs = tuple.newNumber
            lcdDisplayText = tuple.newLcdDisplayText
        case .rightHandSide:
            let tuple = appendNumber(number, toPreviousInput: mathEquation.rhs ?? .zero)
            mathEquation.rhs = tuple.newNumber
            lcdDisplayText = tuple.newLcdDisplayText
        }
    }
    
    private func appendNumber(_ number: Int, toPreviousInput previousInput: Decimal) -> (newNumber: Decimal, newLcdDisplayText: String) {
        
        let stringInput = String(number)
        var newStringRepresentation = previousInput.isZero ? "" : lcdDisplayText
        newStringRepresentation.append(stringInput)
        
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.numberStyle = .decimal
        guard let convertNumber = formatter.number(from: newStringRepresentation) else { return (.nan, "Error") }
        
        let newNumber: Decimal = convertNumber.decimalValue
        let newLCDDisplayText = newStringRepresentation
        
        return (newNumber, newLCDDisplayText)
    }
}
