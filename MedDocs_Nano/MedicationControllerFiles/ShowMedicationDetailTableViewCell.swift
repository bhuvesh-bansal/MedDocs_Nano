//
//  ShowMedicationDetailTableViewCell.swift
//  MedDocs_Nano
//
//  Created by Bhuvesh Bansal on 21/01/25.
//

import UIKit

class ShowMedicationDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("ShowMedicationDetailTableViewCell initialized")
    }
}
