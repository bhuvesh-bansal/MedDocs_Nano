//
//  MedicationDetailTableViewCell.swift
//  Medication
//
//  Created by TRISHA on 22/01/25.
//

import UIKit

class MedicationDetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var medicationNameLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var medicineTypeLabel: UILabel!
    
    @IBOutlet weak var startDateLabel: UILabel!
    
    @IBOutlet weak var startTimeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            // Configure the view for the selected state
        }

}
