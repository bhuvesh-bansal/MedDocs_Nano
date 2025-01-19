//
//  AddReportMedicationDetailTableViewCell.swift
//  MedDocs_Nano
//
//  Created by Bhuvesh Bansal on 18/01/25.
//

import UIKit

class AddReportMedicationDetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var addMedicationImageLabel: UILabel!
    @IBOutlet weak var addMedicationNameLabel: UILabel!
    @IBOutlet weak var addMedicationDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
