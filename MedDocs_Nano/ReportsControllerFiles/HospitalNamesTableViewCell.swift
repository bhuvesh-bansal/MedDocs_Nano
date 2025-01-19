//
//  hospitalNamesTableViewCell.swift
//  MedDocs_Nano
//
//  Created by Bhuvesh Bansal on 16/01/25.
//

import UIKit

class HospitalNamesTableViewCell: UITableViewCell {

    @IBOutlet weak var hospitalNameLabel: UILabel!
    
    @IBOutlet weak var hospitalNameImageLabel: UILabel!
    @IBOutlet weak var hospitalDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
