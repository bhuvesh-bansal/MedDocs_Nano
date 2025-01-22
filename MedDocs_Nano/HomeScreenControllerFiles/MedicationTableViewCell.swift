//
//  MedicationTableViewCell.swift
//  HomeScreen_MedDocs
//
//  Created by Vansh Sharma on 20/01/25.
//

import UIKit

class MedicationTableViewCell: UITableViewCell {

    @IBOutlet weak var TypeImage: UIImageView!
    
    @IBOutlet weak var MedicineName: UILabel!
    
    @IBOutlet weak var Dosage: UILabel!
    
    @IBOutlet weak var `Type`: UILabel!
    
    @IBOutlet weak var MedicineDateTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
