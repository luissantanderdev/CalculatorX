//
//  CalculatorEngine.swift
//  Calc
//
//  Created by iOSBFree on 25/01/2022.
//
//
//  iOSBFree Ltd                   → All rights reserved
//  Website                         → https://www.iosbfree.com
//
//  👉 Free Courses                 → https://www.udemy.com/user/iosbfree
//
//  YouTube                         → https://www.youtube.com/channel/UCWBUOVRbtKNml4jN_4bRkCQ
//  Linked In                       → http://www.linkedin.com/in/mattharding-iosbfree
//
//  Tell us what
//  you want to learn
//
//  💜 iOSBFree
//  community@iosbfree.com
//  🧕🏻👨🏿‍💼👩🏼‍💼👩🏻‍💻👨🏼‍💼🧛🏻‍♀️👩🏼‍💻💁🏽‍♂️🕵🏻‍♂️🧝🏼‍♀️🦹🏼‍♀🧕🏾🧟‍♂️
// *******************************************************************************************
//
// → What's This File?
//   It's the core of the calculator. The brain. It generates all of our behaviour.
//   Architecural Layer: Business Logic Layer
//
// *******************************************************************************************


import Foundation

struct CalculatorEngine {
    
    enum OperandSide {
        case leftHandSide
        case rightHandSide
    }
    
    
    // MARK: - Math Equation
    private var mathEquation = MathEquation(lhs: .zero)
    private var operandSide = OperandSide.leftHandSide
    
    // MARK: - LCD Display
    var lcdDisplayText = ""
    
    // MARK: - Extra Functions
    
    mutating func clearPressed() {
        mathEquation = MathEquation(lhs: .zero)
        lcdDisplayText = mathEquation.lhs.formatted()
        operandSide = .leftHandSide
    }
    
    mutating func negatePressed() {
        
    }
    
    mutating func percentagePressed() {
        
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
    
    mutating func equalsPressed() {
        mathEquation.execute()
        lcdDisplayText = mathEquation.result?.formatted() ?? "Error"
    }
    
    // MARK: - Number Input
    
    mutating func decimalPressed() {
        
    }
    
    mutating func numberPressed(_ number: Int) {
        
        let decimalValue = Decimal(number)
        lcdDisplayText = decimalValue.formatted()
        
        
        switch operandSide {
        case .leftHandSide:
            mathEquation.lhs = decimalValue
        case .rightHandSide:
            mathEquation.rhs = decimalValue
        }

    }
}
