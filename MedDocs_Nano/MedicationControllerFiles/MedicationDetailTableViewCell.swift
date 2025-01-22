//
//  MedicationDetailTableViewCell.swift
//  MedDocs_Nano
//
//  Created by Bhuvesh Bansal on 20/01/25.
//

import UIKit

class MedicationDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var medicationImageView: UIImageView!
    @IBOutlet weak var medicationNameLabel: UILabel!
    @IBOutlet weak var medicationDosageLabel: UILabel!
    @IBOutlet weak var medicationTypeLabel: UILabel!
    @IBOutlet weak var medicationDateLabel: UILabel!
    @IBOutlet weak var medicationTimeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        medicationImageView.layer.cornerRadius = medicationImageView.frame.size.width / 2
//        medicationImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
