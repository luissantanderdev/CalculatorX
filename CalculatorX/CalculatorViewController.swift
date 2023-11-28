//
//  ViewController.swift
//  CalculatorX
//
//  Created by Luis Santander on 11/9/23.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var lcdDisplay: UIView!
    @IBOutlet weak var displayLabel: UILabel!
    
    
    @IBOutlet weak var pinpadButton0: UIButton!
    @IBOutlet weak var pinpadButton1: UIButton!
    @IBOutlet weak var pinpadButton2: UIButton!
    @IBOutlet weak var pinpadButton3: UIButton!
    @IBOutlet weak var pinpadButton4: UIButton!
    @IBOutlet weak var pinpadButton5: UIButton!
    @IBOutlet weak var pinpadButton6: UIButton!
    @IBOutlet weak var pinpadButton7: UIButton!
    @IBOutlet weak var pinpadButton8 : UIButton!
    @IBOutlet weak var pinpadButton9: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var negateButton: UIButton!
    @IBOutlet weak var percentageButton: UIButton!
    
    
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var equalsButton: UIButton!
    
    @IBOutlet weak var decimalButton: UIButton!
    
    // MARK: - Color Themes
    
    /*
     gray: #a6a6a6
     dark gray: #333333
     orange: #ff9f0a
     */
    
    var currentTheme: CalculatorTheme {
        return CalculatorTheme(backgroundColor: "#000000", displayColor: "#FFFFFF", extraFunctionColor: "#a6a6a6", extraFunctionFillColor: "#FFFFFF", operationColor: "#ff9f0a", operationTileColor: "#FFFFFF", pinPadColor: "#333333", pinPadTileColor: "#FFFFFF")
    }
    
    // MARK: - Calculator Engine
    private var calculatorEngine = CalculatorEngine()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        decorateView()
    }
    
    // MARK: - Decorate
    
    private func decorateView() {
        view.backgroundColor = UIColor(hex: currentTheme.backgroundColor)
        
        lcdDisplay.backgroundColor = .clear
        displayLabel.textColor = UIColor(hex: currentTheme.displayColor)
        
        decorateButtons()
    }
    
    private func decorateButtons() {
        decoratePinPadButtons(pinpadButton0, true)
        decoratePinPadButtons(pinpadButton1)
        decoratePinPadButtons(pinpadButton2)
        decoratePinPadButtons(pinpadButton3)
        decoratePinPadButtons(pinpadButton4)
        decoratePinPadButtons(pinpadButton5)
        decoratePinPadButtons(pinpadButton6)
        decoratePinPadButtons(pinpadButton7)
        decoratePinPadButtons(pinpadButton8)
        decoratePinPadButtons(pinpadButton9)
        
        decorateExtraFunctionButtons(clearButton)
        decorateExtraFunctionButtons(negateButton)
        decorateExtraFunctionButtons(percentageButton)
        
        decorateOperationButtons(equalsButton)
        decorateOperationButtons(multiplyButton)
        decorateOperationButtons(divideButton)
        decorateOperationButtons(addButton)
        decorateOperationButtons(minusButton)
        
        decoratePinPadButtons(decimalButton)
    }
    
    // DESC: Decorates the bubbles with circles in the UI.
    private func decorateButtons(_ button: UIButton, _ usingSlicedImage: Bool = false) {
        
        let image = usingSlicedImage ? UIImage(named: "CircleSliced") : UIImage(named: "Circle")
        
        button.setBackgroundImage(image, for: .normal)
        button.backgroundColor = .clear
    }
    
    private func decorateExtraFunctionButtons(_ button: UIButton) {
        decorateButtons(button)
        
        button.tintColor = UIColor(hex: currentTheme.extraFunctionColor)
        button.setTitleColor(UIColor(hex: currentTheme.extraFunctionFillColor), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
    }
    
    private func decorateOperationButtons(_ button: UIButton) {
        decorateButtons(button)
    
        button.tintColor = UIColor(hex: currentTheme.operationColor)
        button.setTitleColor(UIColor(hex: currentTheme.operationTileColor), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 50)
    }
    
    private func decoratePinPadButtons(_ button: UIButton, _ usingSlicedImage: Bool = false) {
        decorateButtons(button, usingSlicedImage)
        
        button.tintColor = UIColor(hex: currentTheme.pinPadColor)
        button.setTitleColor(UIColor(hex: currentTheme.pinPadTileColor), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
    }
    
    
    // MARK: - IBActions
    @IBAction private func clearPressed() {
        calculatorEngine.clearPressed()
    }

    @IBAction private func negatePressed() {
        calculatorEngine.negatePressed()
    }

    @IBAction private func percentagePressed() {
        calculatorEngine.percentagePressed()
    }

    
    // MARK: - Operations
    @IBAction private func addPressed() {
        calculatorEngine.addPressed()
    }
    
    @IBAction private func minusPressed() {
        calculatorEngine.minusPressed()
    }
    
    @IBAction private func multiplyPressed() {
        calculatorEngine.multiplyPressed()
    }
    
    @IBAction private func dividePressed() {
        calculatorEngine.dividePressed()
    }
    
    @IBAction private func equalsPressed() {
        calculatorEngine.equalsPressed()
    }
    
    // MARK: - Number Input
    @IBAction private func decimalPressed() {
        calculatorEngine.decimalPressed()
    }
    
    // NOTES: - By accessing the tag attribute allows you
    //          to know which sender button send things.
    @IBAction private func numberPressed(_ sender: UIButton) {
        let number = sender.tag
        
        calculatorEngine.numberPressed(number)
        
    }
}



