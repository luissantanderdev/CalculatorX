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
        
    }
    
}
