//
//  SingleChoiceCell.swift
//  Yelp
//
//  Created by Harshit Mapara on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class SingleChoiceCell: UITableViewCell {

    
    @IBOutlet weak var singleChoiceTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
