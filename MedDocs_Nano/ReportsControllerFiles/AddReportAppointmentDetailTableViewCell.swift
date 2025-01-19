//
//  AddReportAppointmentNameTableViewCell.swift
//  MedDocs_Nano
//
//  Created by Bhuvesh Bansal on 18/01/25.
//

import UIKit

class AddReportAppointmentDetailTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var appointmentNameImageLabel: UILabel!
    @IBOutlet weak var appointmentNameLabel: UILabel!
    @IBOutlet weak var appointmentDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
