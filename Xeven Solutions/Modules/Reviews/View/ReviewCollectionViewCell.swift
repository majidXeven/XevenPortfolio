//
//  ReviewCollectionViewCell.swift
//  Xeven Solutions
//
//  Created by Muhammad Asar on 01/01/2020.
//  Copyright © 2020 IMedHealth. All rights reserved.
//

import UIKit
import FloatRatingView

class ReviewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
