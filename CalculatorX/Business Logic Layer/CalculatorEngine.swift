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
    
    mutating func equalsPressed() {
        mathEquation.execute()
        
        printEquationToDebugConsole()
        // NSLog(mathEquation.generatePrintOut()) // will print out in release build
        lcdDisplayText = mathEquation.result?.formatted() ?? "Error"
    }
    
    
    // MARK: - Debug Console
    // NOTE: This function was created particularly to tell future developers
    //       that this is inteded to just print the math equation to the console.
    //       why because it is expensive operation to print when an app is deployed.
    //       this equation only exists in development. tells all our collegues
    //       that this is for debugging purposes only. 
    private func printEquationToDebugConsole() {
        print("Equation " + mathEquation.generatePrintOut())
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
