//
//  UIButton+Animations.swift
//  CalculatorX
//
//  Created by Luis Santander on 1/6/24.
//

import Foundation
import UIKit

/**
 NOTES:
 -------------------------------------
 UIView is the root class of all views in UIKit for iOS
 
 if you want to be pro at animations you need to either ease in animations or ease out animations. Experiment.
 */

extension UIButton {
    
    func bounce() {
        moveUp()
       // moveUpWithSpringDamping() // use this to use damping function which is the same as moveUp functionality
    }
    
    func growLarger() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn) {
            self.transform = CGAffineTransform(scaleX: 4, y: 4)
        } completion: { _ in
            // do nothing but this fires after animation fires.
        }
    }
    
    func makeSmaller() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn) {
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        } completion: { _ in
            // do nothing but this fires after animation fires.
        }
    }
    
    // NOTES:
    /**
        Using [weak in self] in the nested closure loops helps resolved the issue when it comes to memory management on the stack calls where the reference pointer needs to move. When this animations
           are called they need to be de-allocated from the call stack in ARC.
     
            when you do [weak self] in you are making the object self a weak reference.
     
            Suppose the user navigated to a next screen and animation was running before having [weak self]
                the animation would still be running in the background using device memory but by invoking weak
             reference self this solves the problem that when user moves away the animation would stop.
              making the memory efficiency of the app much better since it de-allocates.
     
            industry standard is to write code how we are communicating to the memory management system ARC.
     */
    
    
    func moveUp() {
        // let imageView = UIImageView() // if you were to use an image
        
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseOut, .allowUserInteraction]) { [weak self] in
            self?.transform = CGAffineTransform(translationX: 0, y: -50)
        } completion: { _ in
            self.moveDown()
        }
    }
    
    func moveDown() {
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseOut, .allowUserInteraction]) { [weak self] in
            self?.transform = CGAffineTransform(translationX: 0, y: 5)
        } completion: { _ in
            UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseOut, .allowUserInteraction]) { [weak self] in
                self?.transform = CGAffineTransform(translationX: 0, y: -2)
            } completion: { _ in
                UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseOut, .allowUserInteraction]) { [weak self] in
                    self?.transform = CGAffineTransform(translationX: 0, y: 0)
                } completion: { _ in
                    // do nothing
                }
            }
        }
    }
    
    func moveUpWithSpringDamping() {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.curveEaseOut, .allowUserInteraction]) { [weak self] in
            self?.transform = CGAffineTransform(translationX: 0, y: 50)
        } completion: { _ in
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: [.curveEaseOut, .allowUserInteraction]) { [weak self] in
                self?.transform = CGAffineTransform(translationX: 0, y: 0)
            } completion: { _ in
                // do nothing
            }
        }
        
    }
}

