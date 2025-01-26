//
//  ReportsCollectionViewCell.swift
//  MedDocs_Nano
//
//  Created by Bhuvesh Bansal on 16/01/25.
//

import UIKit

class ReportDetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var uploadDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("ReportCollectionViewCell initialized")
    }
}

