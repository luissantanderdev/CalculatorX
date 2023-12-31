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
        restoreSavedTheme()
    }
    
    private func populateArrayOfThemes() {
        themes = [darkTheme, purpleTheme, bloodOrangeTheme, darkBlueTheme, electroTheme, lightBlueTheme, lightTheme,
        orangeTheme, pinkTheme, washedOutTheme]
    }
    
    // MARK: - Save & Restore to Disk
    
    private func restoreSavedTheme() {
//        savedThemeIndex = 0
//
//        if let previousThemeIndex = dataStore.getValue() as? Int {
//            savedThemeIndex = previousThemeIndex
//        }
        
//        NOTE: Not good convention it is better to have a Data Store Manager like up above
//        if let previousThemeIndex = UserDefaults.standard.object(forKey: themeStoreKey) as? Int {
//            savedThemeIndex = previousThemeIndex
//        }
        
//        savedTheme = themes[savedThemeIndex]
        
        
        guard let encodedTheme = dataStore.getValue() as? Data else {
            return
        }
        
        let decoder = JSONDecoder()
        if let previousTheme = try? decoder.decode(CalculatorTheme.self, from: encodedTheme) {
            savedTheme = previousTheme
        }
        
    }
    
    private func saveThemeToDisk(_ theme: CalculatorTheme) {
        // dataStore.set(savedThemeIndex)
        // UserDefaults.standard.set(savedThemeIndex, forKey: themeStoreKey)
        
        let encoder = JSONEncoder()
        if let encodedTheme = try? encoder.encode(theme) {
            dataStore.set(encodedTheme)
        }
        
    }
    
    // MARK: - Next Theme
    
    func moveToTheNextTheme() {
        
        // Can we get the index of saved theme
        let currentThemeID = currentTheme.id
        let index: Int? = themes.firstIndex { calculatorTheme in
            calculatorTheme.id == currentThemeID
        }
        
        // guarding against the condition of the saved index
        // reset if something has gone wrong.
        guard let indexOfExistingTheme = index else {
            if let firstTheme = themes.first {
                updateSystemWithTheme(firstTheme)
            }
            return
        }
        
        // move to the next theme
        var newThemeIndex = indexOfExistingTheme + 1
        if newThemeIndex > themes.count - 1 {
            newThemeIndex = 0
        }
        
        // set the theme
        let theme = themes[newThemeIndex]
        updateSystemWithTheme(theme)
    }
    
    private func updateSystemWithTheme(_ theme: CalculatorTheme) {
        savedTheme = theme
        saveThemeToDisk(theme)
    }
}
