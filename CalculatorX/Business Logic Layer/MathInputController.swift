//
//  MathInputController.swift
//  CalculatorX
//
//  Created by Luis Santander on 12/3/23.
//  Following the iOS Calculator Course

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
    
    // MARK: - Constants
    
    private let groupingSymbol = Locale.current.groupingSeparator ?? ","
    private let decimalSymbol = Locale.current.decimalSeparator ?? "."
    private let minusSymbol = "-"
    private let errorMessage = "Error"
    
    // MARK: - Math Equation
    
    // NOTES: -
    /**
        what does private(set) mean? it means that it only allows MathInputController to set a new Math Equation within
         it's scope domain but it allows external code to access the math equation. basically its privatizes setting a new value for
          the math equation but allows public access in retrieving the value.
     */
    
    private(set) var mathEquation = MathEquation(lhs: .zero)
    private var isEnteringDecimal = false
    
    // MARK: - Initialize
    
    init(byPopulatingResultFrom mathInputController: MathInputController) {
        lhs = mathInputController.result ?? Decimal(0)
    }
    
    init(byPopulatingCalculationFrom mathInputController: MathInputController) {
        lhs = mathInputController.result ?? Decimal(0)
        operation = mathInputController.mathEquation.operation
        rhs = mathInputController.mathEquation.rhs
    }
    
    // MARK: - LCD Display
    
    var lcdDisplayText = ""
    
    // MARK: - Equation Wrapper
    
    var operation: MathEquation.OperationType? {
        get {
            return mathEquation.operation
        }
        set {
            mathEquation.operation = newValue
        }
    }
    
    
    var lhs: Decimal {
        get {
            return mathEquation.lhs
        }
        set {
            mathEquation.lhs = newValue
            lcdDisplayText = formatLCDDisplay(mathEquation.lhs)
        }
    }
    
    var rhs: Decimal? {
        get {
            return mathEquation.rhs
        }
        set {
            mathEquation.rhs = newValue
            lcdDisplayText = formatLCDDisplay(mathEquation.rhs)
        }
    }
    
    // This is Property in Swift
    var result: Decimal? {
        get {
            return mathEquation.result
        }
        set {
            mathEquation.result = newValue
            lcdDisplayText = formatLCDDisplay(mathEquation.result)
        }
    }

    // This is a Function in Swift
    func generatePrintOut() -> String {
        return mathEquation.generatePrintOut()
    }
    
    // MARK: - Initializer
    
    init() {
        lcdDisplayText = formatLCDDisplay(mathEquation.lhs)
    }
    
    // MARK: - Extra Functions
    
    mutating func negatePressed() {
        guard isCompleted == false else { return }
        
        switch operandSide {
        case .leftHandSide:
            mathEquation.negateLeftHandSide()
            displayNegateSymbolOnDisplay(mathEquation.lhs)
        case .rightHandSide:
            mathEquation.negateRightHandSide()
            displayNegateSymbolOnDisplay(mathEquation.rhs)
        }
    }
    
    mutating private func displayNegateSymbolOnDisplay(_ decimal: Decimal?) {
        guard let decimal = decimal else { return }
        
        let isNegativeValue = decimal < 0 ? true : false
        if isNegativeValue {
            lcdDisplayText.addPrefixIfNeeded(minusSymbol)
        } else {
            lcdDisplayText.removePrefixIfNeeded(minusSymbol)
        }
    }
    
    mutating func percentagePressed() {
        guard isCompleted == false else { return }
        
        switch operandSide {
        case .leftHandSide:
            mathEquation.applyPercentageToLeftHandSide()
            lcdDisplayText = formatLCDDisplay(mathEquation.lhs)
        case .rightHandSide:
            mathEquation.applyPercentageToRightHandSide()
            lcdDisplayText = formatLCDDisplay(mathEquation.rhs)
        }
    }
    
    // MARK: - Operations
    
    mutating func addPressed() {
        guard isCompleted == false else { return }

        mathEquation.operation = MathEquation.OperationType.add
        startEditingRightHandSide()
    }
    
    mutating func minusPressed() {
        guard isCompleted == false else { return }

        mathEquation.operation = MathEquation.OperationType.subtract
        startEditingRightHandSide()
    }
    
    mutating func multiplyPressed() {
        guard isCompleted == false else { return }

        mathEquation.operation = MathEquation.OperationType.multiply
        startEditingRightHandSide()
    }
    
    mutating func dividePressed() {
        guard isCompleted == false else { return }

        mathEquation.operation = MathEquation.OperationType.divide
        startEditingRightHandSide()
    }
    
    mutating func execute() {
        guard isCompleted == false else { return }
        
        mathEquation.execute()
        lcdDisplayText = formatLCDDisplay(mathEquation.result)
    }
    
    // MARK: - Editing Right Hand Side
    
    mutating private func startEditingRightHandSide() {
        operandSide = .rightHandSide
        isEnteringDecimal = false
    }
    
    // MARK: - Number Input
    
    mutating func decimalPressed() {
        isEnteringDecimal = true 
        lcdDisplayText = appendDecimalPointIfNeeded(lcdDisplayText)
    }
    
    private func appendDecimalPointIfNeeded(_ string: String) -> String {
        if string.contains(decimalSymbol) {
            return string
        }
        
        return string.appending(decimalSymbol)
    }
    
    mutating func numberPressed(_ number: Int) {
        guard number >= -9, number <= 9 else { return }
        
        switch operandSide {
        case .leftHandSide:
            let tuple = appendNewNumber(number, toPreviousInput: mathEquation.lhs)
            mathEquation.lhs = tuple.newNumber
            lcdDisplayText = tuple.newLcdDisplayText
        case .rightHandSide:
            let tuple = appendNewNumber(number, toPreviousInput: mathEquation.rhs ?? .zero)
            mathEquation.rhs = tuple.newNumber
            lcdDisplayText = tuple.newLcdDisplayText
        }
    }
    
    private func appendNewNumber(_ number: Int, toPreviousInput previousInput: Decimal) -> (newNumber: Decimal, newLcdDisplayText: String) {
        
        guard isEnteringDecimal == false else {
            return appendNewDecimalNumber(number)
        }
        
        let stringInput = String(number)
        var newStringRepresentation = previousInput.isZero ? "" : lcdDisplayText
        newStringRepresentation.append(stringInput)
        
        newStringRepresentation = newStringRepresentation.replacingOccurrences(of: groupingSymbol, with: "")
        
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.numberStyle = .decimal
        guard let convertNumber = formatter.number(from: newStringRepresentation) else { return (.nan, errorMessage) }
        
        let newNumber: Decimal = convertNumber.decimalValue
        let newLCDDisplayText = formatLCDDisplay(newNumber)
        return (newNumber, newLCDDisplayText)
    }
    
    // NOTE: let is a constant in swift
    
    private func appendNewDecimalNumber(_ number: Int) -> (newNumber: Decimal, newLcdDisplayText: String) {
        let stringInput = String(number)
        let newLCDDisplayText = lcdDisplayText.appending(stringInput)
        
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.numberStyle = .decimal
        guard let convertNumber = formatter.number(from: newLCDDisplayText) else { return (.nan, errorMessage) }
        
        let newNumber: Decimal = convertNumber.decimalValue
        return (newNumber, newLCDDisplayText)
    }
    
    // MARK: - LCD Display Formatting
    
    /**
        Notes:
            Let's apply the dry principle for the formatting of the decimal. we are going to centralize the code.
                
     */
    private func formatLCDDisplay(_ decimal: Decimal?) -> String {
        guard
            let decimal = decimal,
            decimal.isNaN == false
        else { return errorMessage }
    
        return decimal.formatted()
    }
    
    // MARK: - Computed Properties
    
    var isCompleted: Bool {
        return mathEquation.executed
    }
    
    var isReadyToExecute: Bool {
        guard mathEquation.executed == false else {
            return false
        }
        
        if let _ = mathEquation.operation,
           let _ = mathEquation.rhs {
            return true
        }
        
        return false 
    }
    
    // MARK: - Copy & Paste
    
    mutating func pasteIn(_ decimal: Decimal) {
        switch operandSide {
        case .leftHandSide:
            mathEquation.lhs = decimal
        case .rightHandSide:
            mathEquation.rhs = decimal
        }
        
        lcdDisplayText = formatLCDDisplay(decimal)
    }

}
