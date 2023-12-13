//
//  MathEquation.swift
//  CalculatorX
//
//  Created by Luis Santander on 11/27/23.
//

import Foundation

// NOTES:
/**
 
 Single Responsiblity principle means a struct only has one purpose one responsibility only. Not Multiple. 
 
 */

struct MathEquation {
    
    enum OperationType {
        case add
        case subtract
        case multiply
        case divide
    }
    
    // see some change -<<<<<<
    
    var lhs: Decimal // cannot be optional
    var rhs: Decimal?
    var operation: OperationType?
    var result: Decimal?
    
    // MARK: - Execution
    
    var executed: Bool {
        return result != nil
    }
    
    // or you can just leave executed as a variable and maintain it by
    
    // mutating explicitly tells to mutate the result variable as seen in the execute() struct function 
    mutating func execute() {
        // executed = true
        // guard: Don't let the code continue unless its what it means
        guard
            let rhs = self.rhs,
            let operation = operation else {
                return
            }
        
        switch operation {
        case .add:
            result = lhs + rhs
        case .subtract:
            result = lhs - rhs
        case .multiply:
            result = lhs * rhs
        case .divide:
            result = lhs / rhs
        }
              
    }
    
    // MARK: - Negate
    
    mutating func negateLeftHandSide() {
        lhs.negate()
    }
    
    mutating func negateRightHandSide() {
        rhs?.negate()
    }
    
    // MARK: - Percentage
    
    mutating func applyPercentageToLeftHandSide() {
        lhs = calculatePercentageValue(lhs)
    }
    
    mutating func applyPercentageToRightHandSide() {
        guard let decimal = rhs else { return }
        
        rhs = calculatePercentageValue(decimal)
    }
    
    private func calculatePercentageValue(_ decimal: Decimal) -> Decimal {
        return decimal / 100
    }
    
    // MARK: - String Representation
    
    func generatePrintOut() -> String {
        let operationString = generateStringRepresentationOfOperation()
        return lhs.formatted() + " " + operationString + " " + (rhs?.formatted() ?? "") + " = " + (result?.formatted() ?? "Error")
    }
    
    private func generateStringRepresentationOfOperation() -> String {
        // NOTE: Instead of writing the guard statement you can alseo do the default
        // guard let operation = self.operation else { return "" }
        
        switch operation {
        case .add: return "+"
        case .subtract: return "-"
        case .multiply: return "*"
        case .divide: return "/"
        case .none:
            return ""
        }
    }
}























