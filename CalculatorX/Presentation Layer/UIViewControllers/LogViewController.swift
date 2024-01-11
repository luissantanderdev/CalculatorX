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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
