//
//  ViewController.swift
//  CalculatorX
//
//  Created by Luis Santander on 11/9/23.
//

/**
        Popular to common belief comments are not to be used in code. your code
            must convey to future developers what you are trying to do so what
                my university tought me I have to scrap it in the final refactoring.k
 */

import UIKit

class CalculatorViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var lcdDisplay: LCDDisplay!
    
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
        registerForNotifications()
    }
    
    // MARK: - Gestures
    
    private func addThemeGestureRecognizer() {
        let themeGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.themeGestureRecognizerDidTap(_:)))
        
        themeGestureRecognizer.numberOfTapsRequired = 2
        
        lcdDisplay.addGestureRecognizer(themeGestureRecognizer)
    }
    
    @objc private func themeGestureRecognizerDidTap(_ gesture: UITapGestureRecognizer) {
        lcdDisplay.prepareForColorThemeUpdate()
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
        lcdDisplay.label.textColor = UIColor(hex: currentTheme.displayColor)
        
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
        button.setTitleColor(UIColor(hex: currentTheme.extraFunctionTitleColor), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: extraFunctionsButtonsFontSize)
    }
    
    private func decorateOperationButtons(_ button: UIButton) {
        decorateButtons(button)
    
        button.tintColor = UIColor(hex: currentTheme.operationColor)
        button.setTitleColor(UIColor(hex: currentTheme.operationTitleColor), for: .normal)
        button.setTitleColor(UIColor(hex: currentTheme.operationTitleSelectedColor), for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: operationButtonsFontSize)
    }
    
    private func decoratePinPadButtons(_ button: UIButton, _ usingSlicedImage: Bool = false) {
        decorateButtons(button, usingSlicedImage)
        
        button.tintColor = UIColor(hex: currentTheme.pinpadColor)
        button.setTitleColor(UIColor(hex: currentTheme.pinpadTitleColor), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: pinPadButtonsFontSize)
    }
    
    // MARK: - Select Operation Buttons
    
    private func deselectOperationButtons() {
        selectOperationButton(divideButton, false)
        selectOperationButton(multiplyButton, false)
        selectOperationButton(minusButton, false)
        selectOperationButton(addButton, false)
    }

    private func selectOperationButton(_ button: UIButton, _ selected: Bool) {
        button.tintColor = selected ? UIColor(hex: currentTheme.operationSelectedColor) : UIColor(hex: currentTheme.operationColor)
        button.isSelected = selected
    }
    
    // MARK: - IBActions
    
    @IBAction private func clearPressed() {
        clearButton.bounce()
        deselectOperationButtons()
        
        calculatorEngine.clearPressed()
        refreshLCDDisplay()
    }

    @IBAction private func negatePressed() {
        negateButton.bounce()
        calculatorEngine.negatePressed()
        refreshLCDDisplay()
    }

    @IBAction private func percentagePressed() {
        percentageButton.bounce()
        
        calculatorEngine.percentagePressed()
        refreshLCDDisplay()
    }

    // MARK: - Operations
    @IBAction private func addPressed() {
        addButton.bounce()
        
        deselectOperationButtons()
        selectOperationButton(addButton, true)
        
        calculatorEngine.addPressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func minusPressed() {
        minusButton.bounce()
        
        deselectOperationButtons()
        selectOperationButton(minusButton, true)
        
        calculatorEngine.minusPressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func multiplyPressed() {
        multiplyButton.bounce()
        
        deselectOperationButtons()
        selectOperationButton(multiplyButton, true)
        
        calculatorEngine.multiplyPressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func dividePressed() {
        divideButton.bounce()
        
        deselectOperationButtons()
        selectOperationButton(divideButton, true)
        
        calculatorEngine.dividePressed()
        refreshLCDDisplay()
    }
    
    @IBAction private func equalsPressed() {
        equalsButton.bounce()
        
        deselectOperationButtons()
        selectOperationButton(equalsButton, true)
        
        calculatorEngine.equalsPressed()
        refreshLCDDisplay()
    }
    
    // MARK: - Number Input
    @IBAction private func decimalPressed() {
        decimalButton.bounce()
        deselectOperationButtons()
        
        calculatorEngine.decimalPressed()
        refreshLCDDisplay()
    }
    
    // NOTES: - By accessing the tag attribute allows you
    //          to know which sender button send things.
    @IBAction private func numberPressed(_ sender: UIButton) {
        sender.bounce()
        
        deselectOperationButtons()
        
        let number = sender.tag
        calculatorEngine.numberPressed(number)
        refreshLCDDisplay()
    }
    
    // MARK: - Refresh LCDDisplay
    private func refreshLCDDisplay() {
        lcdDisplay.label.text = calculatorEngine.lcdDisplayText
    }
    
    // MARK: - Notifications
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceivePasteNotification(notification:)), name: Notification.Name("luissantanderdev.com.CalculatorX"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveHistoryLogNotification(notification:)), name: Notification.Name("luissantanderdev.com.CalculatorX.LCDDisplay.displayHistory"), object: nil)
    }
    
    @objc private func didReceivePasteNotification(notification: Notification) {
        guard let doubleValue = notification.userInfo?["PasteKey"] as? Double else { return }
        
        pasteNumberIntoCalculator(from: Decimal(doubleValue))
    }
    
    @objc private func didReceiveHistoryLogNotification(notification: Notification) {
        presentHistoryLogScreen()
    }
    
    private func presentHistoryLogScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let logViewController = storyboard.instantiateViewController(withIdentifier: "LogViewController") as? LogViewController else {
            return
        }
        
        logViewController.datasource = calculatorEngine.historyLog
        present(logViewController, animated: true, completion: nil)
    }
    
    // MARK: - Copy & Paste
    
    private func pasteNumberIntoCalculator(from decimal: Decimal) {
        calculatorEngine.pasteInNumber(from: decimal)
        refreshLCDDisplay()
    }
    
    // MARK: - Debugging
    
    private func printAtLine(number: Int, output: Any?) {
        guard let output = output else { return }
        print(String(describing: type(of: self)))
        print("\(number): \(output)")
    }
}



