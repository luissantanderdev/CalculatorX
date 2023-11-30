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
    
    
    // mutating explicitly tells to mutate the result variable.
    mutating func execute() {
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
}
