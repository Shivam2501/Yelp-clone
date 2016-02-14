//
//  BusinessCellTableViewCell.swift
//  Yelp
//
//  Created by Shivam Bharuka on 2/13/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCellTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingsImageView: UIImageView!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var business: Business! {
        didSet{
            nameLabel.text=business.name
            thumbImageView.setImageWithURL(business.imageURL!)
            categoryLabel.text=business.categories
            addressLabel.text=business.address
            ratingsImageView.setImageWithURL(business.ratingImageURL!)
            distanceLabel.text=business.distance
            ratingsLabel.text="\(business.reviewCount!) Reviews"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbImageView.layer.cornerRadius = 3
        thumbImageView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
