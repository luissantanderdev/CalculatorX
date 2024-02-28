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
        if inputController.isCompleted {
            populateFromResult()
        }
        
        inputController.negatePressed()
    }
    
    mutating func percentagePressed() {
        if inputController.isCompleted {
            populateFromResult()
        }
        
        inputController.percentagePressed()
    }
    
    // MARK: - Operations
    
    // NOTES
    /**
            Sphagetti Code occurs when you are accessing a variable such as the inputController.mathEquation.result
            and setting a value which breaks the single responsibility architecture of the MathInputController.
            You are accessing code that is out of bounds on what should be accessed by the Calculator Engine.
     
            Layered Architecture.
     */
        
    mutating func addPressed() {
        // guard inputController.isCompleted == false else { return } // <-- Use this if no subsequent equals.
        // accept the result and pace it into a new MathInput Controller
        // accept the operation
        // allow the user to enter the rhs of the equation
        if inputController.isReadyToExecute {
            executeMathInputController()
            populateFromResult()
        }
        
        if inputController.isCompleted {
            populateFromResult()
        }
        
        inputController.addPressed()
    }
    
    mutating func minusPressed() {
        if inputController.isReadyToExecute {
            executeMathInputController()
            populateFromResult()
        }
        
        if inputController.isCompleted {
            populateFromResult()
        }
        
        inputController.minusPressed()
    }
    
    mutating func multiplyPressed() {
        // Commit an equation if needed if we subsequently keep pressing the multiply button
        // execute the equation if ready
        
        // TODO: - To Create this features.
        // task 1: set result to left hand side
        // task 2: multiply would be appended.
        
        if inputController.isReadyToExecute {
            executeMathInputController()
            populateFromResult()
            // 5 * 5 * <--- this scenario 
        }
        
        if inputController.isCompleted {
            populateFromResult()
        }
        
        inputController.multiplyPressed()
    }
    
    mutating func dividePressed() {
        if inputController.isReadyToExecute {
            executeMathInputController()
            populateFromResult()
        }
        
        if inputController.isCompleted {
            populateFromResult()
        }
        
        inputController.dividePressed()
    }
    
    mutating func equalsPressed() {
        if inputController.isCompleted {
            inputController = MathInputController(byPopulatingCalculationFrom: inputController)
        }
        
        guard inputController.isReadyToExecute else { return }
        executeMathInputController()
        // NSLog(mathEquation.generatePrintOut()) // will print out in release build
    }
    
    mutating private func executeMathInputController() {
        inputController.execute()
        historyLog.append(inputController.mathEquation)
        printEquationToDebugConsole()
    }
    
    // MARK: - Populate New Math Input Controller
    
    private mutating func populateFromResult() {
        inputController = MathInputController(byPopulatingResultFrom: inputController)
    }
    
    // MARK: - Debug Console
    
    // NOTE: This function was created particularly to tell future developers
    //       that this is inteded to just print the math equation to the console.
    //       why because it is expensive operation to print when an app is deployed.
    //       this equation only exists in development. tells all our collegues
    //       that this is for debugging purposes only. 
    private func printEquationToDebugConsole() {
        print("Equation " + inputController.generatePrintOut())
    }
    
    private func printAtLine(number: Int, output: Any?) {
        guard let printOut = output as? String else { return }
        print("\(number): \(printOut)")
    }
    
    // MARK: - Number Input
    
    mutating func decimalPressed() {
        if inputController.isCompleted {
            inputController = MathInputController()
        }
        
        inputController.decimalPressed()
    }
    
    mutating func numberPressed(_ number: Int) {
        if inputController.isCompleted {
            inputController = MathInputController()
        }
        
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
    
    mutating func pasteInMathEquation(from mathEquation: MathEquation) {
        guard let result = mathEquation.result else { return }
        inputController = MathInputController()
        pasteInNumber(from: result)
    }
}
