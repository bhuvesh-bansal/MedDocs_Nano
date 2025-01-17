//
//  MedicationTableViewCell.swift
//  MedDocs_Nano
//
//  Created by Bhuvesh Bansal on 16/01/25.
//

import UIKit

class MedicationTableViewCell: UITableViewCell {

    
    @IBOutlet weak var medicationImageTextLabel: UILabel!
    
    @IBOutlet weak var medicationNameLabel: UILabel!
    @IBOutlet weak var medicationDosage: UILabel!
    @IBOutlet weak var medicineTiming: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
