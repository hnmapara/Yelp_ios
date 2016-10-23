//
//  BusinessCell.swift
//  Yelp
//
//  Created by Harshit Mapara on 10/22/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    
    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var buisnessTitle: UILabel!
    @IBOutlet weak var reviewImageView: UIImageView!
    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var buisnessAddress: UILabel!
    @IBOutlet weak var buisnessType: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    var business: Business! {
        didSet {
            businessImageView.setImageWith(business.imageURL!)
            buisnessTitle.text = business.name
            reviewImageView.setImageWith(business.ratingImageURL!)
            reviewCount.text = "\(business.reviewCount!) reviews"
            buisnessAddress.text = business.address
            buisnessType.text = business.categories
            distance.text = business.distance!
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        businessImageView.layer.cornerRadius = 4
        businessImageView.clipsToBounds = true
        buisnessTitle.preferredMaxLayoutWidth = buisnessTitle.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buisnessTitle.preferredMaxLayoutWidth = buisnessTitle.frame.size.width
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
