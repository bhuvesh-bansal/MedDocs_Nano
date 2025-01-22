//
//  AppointmentMainPageNamesTableViewCell.swift
//  MedDocs_Nano
//
//  Created by Bhuvesh Bansal on 20/01/25.
//

import UIKit

class AppointmentDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var appointmentNameImageTextLabel: UILabel!
    @IBOutlet weak var appointmentNameLabel: UILabel!
    @IBOutlet weak var appointmentDateLabel: UILabel!
    @IBOutlet weak var appointmentStatusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("AppointmentDetailTableViewCell initialized")
    }
}

