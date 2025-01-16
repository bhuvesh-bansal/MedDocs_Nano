//
//  tagsDetailTableViewCell.swift
//  MedDocs_Nano
//
//  Created by Bhuvesh Bansal on 16/01/25.
//

import UIKit

class tagsDetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var tagImageView: UIImageView!
    @IBOutlet weak var tagNameLabel: UILabel!
    @IBOutlet weak var tagDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Make the image view rounded
        tagImageView.layer.cornerRadius = tagImageView.frame.size.width / 2
        tagImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
