//
//  TagSortCollectionViewCell.swift
//  MedDocs_Nano
//
//  Created by Bhuvesh Bansal on 16/01/25.
//

import UIKit

import UIKit

class TagSortCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tagNameLabel: UILabel!

    // Configure the cell appearance based on selection state
    func configure(isSelected: Bool) {
        if isSelected {
            self.contentView.backgroundColor = UIColor(hex: "00AFB9") // Selected color
            self.contentView.layer.borderWidth = 0 // No border for selected item
        } else {
            self.contentView.backgroundColor = .white // Default background color
            self.contentView.layer.borderWidth = 1 // Black border for unselected items
            self.contentView.layer.borderColor = UIColor.init(hex: "00AFB9").cgColor
        }

        // Corner radius for rounded edges
        self.contentView.layer.cornerRadius = 8
        self.contentView.layer.masksToBounds = true
    }
}

