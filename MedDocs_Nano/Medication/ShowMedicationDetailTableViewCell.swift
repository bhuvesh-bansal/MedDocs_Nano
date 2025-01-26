//
//  ShowMedicationDetailTableViewCell.swift
//  Medication
//
//  Created by TRISHA on 23/01/25.
//

import UIKit

class ShowMedicationDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
