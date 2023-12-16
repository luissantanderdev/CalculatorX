//
//  ThemeManager.swift
//  CalculatorX
//
//  Created by Luis Santander on 12/15/23.
//

import Foundation

/**
 NOTES:
 -------------------------------------
 Singleton Design Pattern
 - A singleton in programming is a design pattern that restricts the instantiation of class
     to a single instance and provides a global point of access to that instance. It's often used to control
         access to resources, manage global state, or coordinate actions within a system.
 */

class ThemeManager {
        
    // MARK: Data Storage
    
    private var dataStore = DataStoreManager(key: "luissantanderdev.com.CalculatorX.ThemeManager.ThemeIndex")
    

    // MARK: - Singleton
    
    // declare a singleton.
    static let shared = ThemeManager()
    
    // MARK: - Themes
    
    private var savedThemeIndex = 0
    private(set) var themes: [CalculatorTheme] = []
    private var savedTheme: CalculatorTheme?
    var currentTheme: CalculatorTheme {
        guard let savedTheme = savedTheme else {
            return themes.first ?? darkTheme
        }
        
        return savedTheme
    }
    
    // MARK: - Lifecycle
    
    init() {
        populateArrayOfThemes()
        restoreSavedThemeIndex()
    }
    
    private func populateArrayOfThemes() {
        themes = [darkTheme, purpleTheme, bloodOrangeTheme, darkBlueTheme, electroTheme, lightBlueTheme, lightTheme, orangeTheme, pinkTheme, washedOutTheme]
    }
    
    // MARK: - Save & Restore to Disk
    
    private func restoreSavedThemeIndex() {
        savedThemeIndex = 0
        
        if let previousThemeIndex = dataStore.getValue() as? Int {
            savedThemeIndex = previousThemeIndex
        }
        
//        NOTE: Not good convention it is better to have a Data Store Manager like up above
//        if let previousThemeIndex = UserDefaults.standard.object(forKey: themeStoreKey) as? Int {
//            savedThemeIndex = previousThemeIndex
//        }
        
        savedTheme = themes[savedThemeIndex]
    }
    
    private func saveThemeIndexToDisk() {
        
        dataStore.set(savedThemeIndex)
        
        // UserDefaults.standard.set(savedThemeIndex, forKey: themeStoreKey)
    }
    
    // MARK: - Next Theme
    
    func moveToTheNextTheme() {
        savedThemeIndex = savedThemeIndex + 1
        
        if savedThemeIndex > themes.count - 1 {
            savedThemeIndex = 0
        }
        
        savedTheme = themes[savedThemeIndex]
        saveThemeIndexToDisk()
    }
}
