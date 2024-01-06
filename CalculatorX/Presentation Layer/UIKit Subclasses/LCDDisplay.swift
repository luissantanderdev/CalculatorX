//
//  LCDDisplay.swift
//  CalculatorX
//
//  Created by Luis Santander on 12/19/23.
//

// NOTES: You need to disconnect IBOutlets from the main Story or it will cause a crash. 

import UIKit

class LCDDisplay: UIView {
    
    // MARK: - IBOutlets
    
    @IBOutlet var label: UILabel!
    
    // MARK: - Initialisers
    
    // Either create this class in code by using this initialisers
    // creating a storyboard in code.
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
        
//        If you don't want future developers to use this way of creating a LCDDisplay
//        print("Unsupported use of the LCDDisplayCLass")
//        fatalError()
    }
    
    // Or create by linking the Story Board.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    private func sharedInit() {
        addMenuGestureRecogniser()
    }
    
    // MARK: - Gesture Recoginser
    
    private func addMenuGestureRecogniser() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressGestureEventFired(_:)))
        addGestureRecognizer(longPressGesture)
    }
    
    @objc private func longPressGestureEventFired(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            print("We want this state here when user touches down")
            showMenu(from: gesture)
        default:
            print("Ignore these states")
            break
        }
    }
    
    // MARK: - UIMenuController
    
    
    // NOTES:
    /**
the height of 44 is categorized with the size of our fingers in relation to the LCD Display.
     
     Becoming the First Responder:

     1. When a user interacts with a UI element (e.g., tapping on a text field), that element becomes the first responder.
     Some UI elements automatically become the first responder when they are tapped or clicked.
     Handling User Input:

     2. Once an object becomes the first responder, it can respond to user input events, such as keyboard input or touch events.
     The object can implement methods to handle and process the input.
     Resigning First Responder Status:

     3. The first responder status can be resigned by calling the resignFirstResponder() method on the current first responder.
     This typically happens when the user taps outside the current input field or when a specific action is triggered.
     
     Example:
     Class MyViewController: UIViewController {
         override func viewDidLoad() {
             super.viewDidLoad()
             
             // Make the view controller the first responder
             self.becomeFirstResponder()
         }

         override var canBecomeFirstResponder: Bool {
             return true
         }

         // Implement methods to handle events
         override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
             // Handle motion event
         }
     }
     */
    private func showMenu(from gestureRecogniser: UILongPressGestureRecognizer) {
        becomeFirstResponder()
        
        let menu = UIMenuController.shared
        guard menu.isMenuVisible == false else { return }
        
        let locationOfTouch = gestureRecogniser.location(in: self)
        var rect = bounds
        rect.origin = locationOfTouch
        rect.origin.y = rect.origin.y - 20 // <- y-axis from the touch press
        rect.size = CGSize(width: 1, height: 44)
        menu.showMenu(from: self, rect: rect)
    }
    
    private func hideMenu() {
        UIMenuController.shared.hideMenu(from: self)
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.copy(_:)) || action == #selector(UIResponderStandardEditActions.paste(_:))
    }
    
    @objc override func copy(_ sender: Any?) {
        UIPasteboard.general.string = label.text
    }
    
    @objc override func paste(_ sender: Any?) {
        guard let numberToPaste = UIPasteboard.general.string?.doubleValue else { return }

//        print("Pasting " + (stringFromPasteBoard ?? "nil"))
//        print("Pasting \(String(describing: doubleValueFromPasteboard))")
        
        // TODO: Inform Calculator System of Number -> doubleValueFromPaste
        
        let userInfo: [AnyHashable: Any] = ["PasteKey": numberToPaste]
    
        // It will broadcast a notification out into the world which if someone is
        // listening to this will receive the notification.
        NotificationCenter.default.post(name: Notification.Name("luissantanderdev.com.CalculatorX"), object: nil, userInfo: userInfo)

    }
    
    // MARK: - Debugging
    
    private func printAtLine(number: Int, output: Any?) {
        guard let output = output else { return }
        print(String(describing: type(of: self)))
        print("\(number): \(output)")
    }
    
    // MARK: Color Themes
    
    func prepareForColorThemeUpdate() {
        hideMenu()
    }
}
