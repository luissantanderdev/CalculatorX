//
//  ViewController.swift
//  CalculatorX
//
//  Created by Luis Santander on 11/9/23.
//

/**
        Popular to common belief comments are not to be used in code. your code
            must convey to future developers what you are trying to do so what
                my university tought me I have to scrap it in the final refactoring.
 
 
 
 */

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
    
    // MARK: - Constants

    private var extraFunctionsButtonsFontSize: CGFloat = 30
    private var operationButtonsFontSize: CGFloat = 40
    private var pinPadButtonsFontSize: CGFloat = 30
    
    // MARK: - Color Themes
    
    private var currentTheme: CalculatorTheme {
        return ThemeManager.shared.currentTheme
    }
        
    // MARK: - Calculator Engine
    private var calculatorEngine = CalculatorEngine()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        addThemeGestureRecognizer()
        redecorateView()
    }
    
    // MARK: - Gestures
    
    private func addThemeGestureRecognizer() {
        let themeGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.themeGestureRecognizerDidTap(_:)))
        
        themeGestureRecognizer.numberOfTapsRequired = 2
        
        lcdDisplay.addGestureRecognizer(themeGestureRecognizer)
    }
    
    @objc private func themeGestureRecognizerDidTap(_ gesture: UITapGestureRecognizer) {
        decorateViewWithNextTheme()
    }
    
    // MARK: - Decorate
    
    private func decorateViewWithNextTheme() {
        print("User did tap")
        ThemeManager.shared.moveToTheNextTheme()
        redecorateView()
    }
    
    private func redecorateView() {
        view.backgroundColor = UIColor(hex: currentTheme.backgroundColor)
        
        lcdDisplay.backgroundColor = .clear
        displayLabel.textColor = UIColor(hex: currentTheme.displayColor)
        
        setNeedsStatusBarAppearanceUpdate()
        
        decorateButtons()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        switch currentTheme.statusBarStyle {
        case .light: return .lightContent
        case .dark: return .darkContent
        }
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
        button.titleLabel?.font = UIFont.systemFont(ofSize: extraFunctionsButtonsFontSize)
    }
    
    private func decorateOperationButtons(_ button: UIButton) {
        decorateButtons(button)
    
        button.tintColor = UIColor(hex: currentTheme.operationColor)
        button.setTitleColor(UIColor(hex: currentTheme.operationTitleColor), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: operationButtonsFontSize)
    }
    
    private func decoratePinPadButtons(_ button: UIButton, _ usingSlicedImage: Bool = false) {
        decorateButtons(button, usingSlicedImage)
        
        button.tintColor = UIColor(hex: currentTheme.pinpadColor)
        button.setTitleColor(UIColor(hex: currentTheme.pinpadTitleColor), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: pinPadButtonsFontSize)
    }
    
    // MARK: - IBActions
    @IBAction private func clearPressed() {
        calculatorEngine.clearPressed()
        refreshLCDDisplay()
    }

    @IBAction private func negatePressed() {
        calculatorEngine.negatePressed()
        refreshLCDDisplay()
    }

    @IBAction private func percentagePressed() {
        calculatorEngine.percentagePressed()
        refreshLCDDisplay()
    }

    // MARK: - Operations
    @IBAction private func addPressed() {
        calculatorEngine.addPressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func minusPressed() {
        calculatorEngine.minusPressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func multiplyPressed() {
        calculatorEngine.multiplyPressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func dividePressed() {
        
        calculatorEngine.dividePressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func equalsPressed() {
        calculatorEngine.equalsPressed()
        refreshLCDDisplay()
    }
    
    // MARK: - Number Input
    @IBAction private func decimalPressed() {
        calculatorEngine.decimalPressed()
        refreshLCDDisplay()
    }
    
    // NOTES: - By accessing the tag attribute allows you
    //          to know which sender button send things.
    @IBAction private func numberPressed(_ sender: UIButton) {
        let number = sender.tag
        
        calculatorEngine.numberPressed(number)
        refreshLCDDisplay()
        
    }
    
    // MARK: - Refresh LCDDisplay
    private func refreshLCDDisplay() {
        displayLabel.text = calculatorEngine.lcdDisplayText
    }
}



