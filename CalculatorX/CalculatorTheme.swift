//
//  CalculatorTheme.swift
//  CalculatorX
//
//  Created by Luis Santander on 11/21/23.
//

import Foundation

// NOTE: We do not want to use UIKit because it creates to much of a dependency to the framework
//       so it is best to utilize our own function that converts a string hex value to r,g,b
//       basically decoupling from the framework.


struct CalculatorTheme {
    let backgroundColor: String
    let displayColor: String
    
    let extraFunctionColor: String
    let extraFunctionFillColor: String
    
    let operationColor: String
    let operationTileColor: String
    
    let pinPadColor: String
    let pinPadTileColor: String
}
