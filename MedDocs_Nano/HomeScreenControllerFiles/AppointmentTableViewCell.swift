//
//  AppointmentTableViewCell.swift
//  HomeScreen_MedDocs
//
//  Created by Vansh Sharma on 20/01/25.
//

import UIKit

class AppointmentTableViewCell: UITableViewCell {

    @IBOutlet weak var HospitalLabel: UILabel!
    
    @IBOutlet weak var HospitalName: UILabel!
    
    @IBOutlet weak var Detail: UILabel!
    
    @IBOutlet weak var AppointmentDateTime: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
