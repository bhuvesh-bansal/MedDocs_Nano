//
//  AppointmentMainPageNamesTableViewCell.swift
//  MedDocs_Nano
//
//  Created by Bhuvesh Bansal on 20/01/25.
//

import UIKit

class AppointmentMainPageNamesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var appointmentNameImageTextLabel: UILabel! // E.g., "Dental Checkup"
    @IBOutlet weak var appointmentNameLabel: UILabel! // E.g., "Dr. Smith"
    @IBOutlet weak var appointmentDateLabel: UILabel! // E.g., "20/01/2025"
    @IBOutlet weak var appointmentStatusLabel: UILabel! // E.g., "Upcoming"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
