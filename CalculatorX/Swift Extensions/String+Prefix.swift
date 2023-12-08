//
//  String+Prefix.swift
//  CalculatorX
//
//  Created by Luis Santander on 12/7/23.
//

import Foundation

/**
 NOTES:
 
 If we want to create extension for the object classes like the String class or others it is good convention
 to utilize String+Prefix the language type object plus the additional functionality that is going to be created for it
 */

extension String {
    
    mutating func addPrefixIfNeeded(_ prefix: String) {
        guard hasPrefix(prefix) == false else { return }
        
        self = prefix + self
    }
    
    mutating func removePrefixIfNeeded(_ prefix: String) {
        guard hasPrefix(prefix) else { return }
        
        self = replacingOccurrences(of: prefix, with: "")
    }
}
