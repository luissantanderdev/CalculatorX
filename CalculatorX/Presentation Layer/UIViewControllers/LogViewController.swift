//
//  LogViewController.swift
//  CalculatorX
//
//  Created by Luis Santander on 1/11/24.
//

import UIKit

// NOTES:
/**
 
 If you want to have a serious career in iOS you must never force unwrap optionals but always guard against them or set a default value in order
 to protect yourself against nil values.
 
 
 */

class LogViewController: UITableViewController {
    
    // MARK: - Data Source
    
    var datasource: [MathEquation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        decorateView()
        setupNavigationBar()
    }
    
    // MARK: - Navigation Bar
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneButtonPressed))
    }
    
    @objc private func doneButtonPressed() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EquationTableViewCell", for: indexPath) as? EquationTableViewCell else {
            return UITableViewCell()
        }
        
        // Configure the cell...
        
        let equation = datasource[indexPath.row]
        cell.lhsLabel.text = equation.lhs.formatted()
        cell.rhsLabel.text = equation.generateStringRepresentationOfOperation() + " " + (equation.rhs?.formatted() ?? "")
        cell.resultLabel.text = "= " + (equation.result?.formatted() ?? "")
        cell.resultLabel.font = UIFont.boldSystemFont(ofSize: cell.resultLabel.font.pointSize + 2)
        cell.selectedBackgroundView = UIView() // When cell is created we create a UIView for it.
        
        decorateCell(cell)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? EquationTableViewCell else {
            return
        }
        
        let equation = datasource[indexPath.row]
        let userInfo: [AnyHashable: Any] = ["PasteKey" : equation]
        
        NotificationCenter.default.post(name: NSNotification.Name("luissantanderdev.com.CalculatorX.LogViewController.pasteMathEquation"), object: nil, userInfo: userInfo)
        
        tableView.isUserInteractionEnabled = false // <- prevent the user from interacting with table further.
        cell.displayTick() 
        dismissAfterDelay()
    }
    
    private func dismissAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: Decorate
    
    // NOTES:
    /**
        (_ <_--------> the underscore in the function means that is referencing the cell object instead of passing it by value.
     */
    
    private func decorateCell(_ cell: EquationTableViewCell) {
        let theme = ThemeManager.shared.currentTheme
        cell.backgroundColor = UIColor(hex: theme.backgroundColor)
        cell.selectedBackgroundView?.backgroundColor = UIColor(hex: theme.operationColor)
        cell.lhsLabel.textColor = UIColor(hex: theme.displayColor)
        cell.rhsLabel.textColor = UIColor(hex: theme.displayColor)
        cell.resultLabel.textColor = UIColor(hex: theme.displayColor)
        cell.lhsLabel.highlightedTextColor = UIColor(hex: theme.backgroundColor)
        cell.rhsLabel.highlightedTextColor = UIColor(hex: theme.backgroundColor)
        cell.resultLabel.highlightedTextColor = UIColor(hex: theme.backgroundColor)
        cell.tick.tintColor = UIColor(hex: theme.operationTitleColor) 
    }
    
    private func decorateView() {
        let theme = ThemeManager.shared.currentTheme
        tableView.backgroundColor = UIColor(hex: theme.backgroundColor)
        tableView.tintColor = UIColor(hex: theme.displayColor)
        
        tableView.separatorColor = UIColor(hex: theme.displayColor)
        
        switch theme.statusBarStyle {
        case .light:
            tableView.indicatorStyle = .white
        case .dark:
            tableView.indicatorStyle = .black
        }
    }
}
