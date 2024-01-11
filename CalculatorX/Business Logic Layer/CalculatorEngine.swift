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


// NOTES: -
/**
 
 The calculator engine is the API that is exposed to the presentation layer.
 
 for consitancy we added guard inputController.isCompleted == false else { return } on all functions in order to tell future developers about
 the validation and they can understand the behaviour we implemented. 
 */


struct CalculatorEngine {
    
    // MARK: - Input Controller
    
    private var inputController = MathInputController()
    
    // MARK: - Equation History
    
    private(set) var historyLog: [MathEquation] = []
    
    // MARK: - LCD Display
    
    var lcdDisplayText: String {
        return inputController.lcdDisplayText
    }
    
    // MARK: - Extra Functions
    
    mutating func clearPressed() {
        inputController = MathInputController()
    }
    
    mutating func negatePressed() {
        guard inputController.isCompleted == false else { return }
        
        inputController.negatePressed()
    }
    
    mutating func percentagePressed() {
        guard inputController.isCompleted == false else { return }
        
        inputController.percentagePressed()
    }
    
    // MARK: - Operations
    
    mutating func addPressed() {
        guard inputController.isCompleted == false else { return }
        
        inputController.addPressed()
    }
    
    mutating func minusPressed() {
        guard inputController.isCompleted == false else { return }
        
        inputController.minusPressed()
    }
    
    mutating func multiplyPressed() {
        inputController.multiplyPressed()
    }
    
    mutating func dividePressed() {
        guard inputController.isCompleted == false else { return }
        
        inputController.dividePressed()
    }
    
    mutating func equalsPressed() {
        guard inputController.isCompleted == false else { return }
        
        inputController.execute()
        historyLog.append(inputController.mathEquation)
        printEquationToDebugConsole()
        
        // NSLog(mathEquation.generatePrintOut()) // will print out in release build
        
    }
    
    // MARK: - Debug Console
    // NOTE: This function was created particularly to tell future developers
    //       that this is inteded to just print the math equation to the console.
    //       why because it is expensive operation to print when an app is deployed.
    //       this equation only exists in development. tells all our collegues
    //       that this is for debugging purposes only. 
    private func printEquationToDebugConsole() {
        print("Equation " + inputController.mathEquation.generatePrintOut())
    }
    
    private func printAtLine(number: Int, output: Any?) {
        guard let printOut = output as? String else { return }
        print("\(number): \(printOut)")
    }
    
    // MARK: - Number Input
    
    mutating func decimalPressed() {
        inputController.decimalPressed()
    }
    
    mutating func numberPressed(_ number: Int) {
        inputController.numberPressed(number)
    }
    
    // MARK: - History Log
    
    mutating private func clearHistory() {
        historyLog = []
    }
    
    // MARK: - Copy & Paste
    
    mutating func pasteInNumber(from decimal: Decimal) {
        if inputController.isCompleted {
            inputController = MathInputController()
        }
        
        inputController.pasteIn(decimal)
    }
    
    
    
}
