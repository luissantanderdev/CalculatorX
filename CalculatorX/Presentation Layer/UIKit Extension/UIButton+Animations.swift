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
    
    func moveUp() {
        // let imageView = UIImageView() // if you were to use an image
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut) {
            self.transform = CGAffineTransform(translationX: 0, y: -50)
        } completion: { _ in
            self.moveDown()
        }
    }
    
    func moveDown() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
            self.transform = CGAffineTransform(translationX: 0, y: 5)
        } completion: { _ in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
                self.transform = CGAffineTransform(translationX: 0, y: -2)
            } completion: { _ in
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
                    self.transform = CGAffineTransform(translationX: 0, y: 0)
                } completion: { _ in
                    // do nothing
                }
            }
        }
    }
    
    func moveUpWithSpringDamping() {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
            self.transform = CGAffineTransform(translationX: 0, y: 50)
        } completion: { _ in
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.transform = CGAffineTransform(translationX: 0, y: 0)
            } completion: { _ in
                // do nothing
            }
        }
        
    }
}

