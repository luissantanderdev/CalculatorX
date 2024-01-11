//
//  EquationTableViewCell.swift
//  CalculatorX
//
//  Created by Luis Santander on 1/11/24.
//

import UIKit

class EquationTableViewCell: UITableViewCell {
    
    @IBOutlet var lhsLabel: UILabel!
    @IBOutlet var rhsLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
