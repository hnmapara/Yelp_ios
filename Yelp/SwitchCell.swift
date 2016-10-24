//
//  SwitchCell.swift
//  Yelp
//
//  Created by Harshit Mapara on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    @objc optional func swithcCell(switchCell: SwitchCell, didChangedValue value: Bool)
}

class SwitchCell: UITableViewCell {

    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var onSwitch: UISwitch!
    
    weak var delegate : SwitchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        onSwitch.addTarget(self, action: "swithcValueChanged", for: UIControlEvents.valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func swithcValueChanged() {
        print("switch value changed")
        delegate?.swithcCell?(switchCell: self, didChangedValue: onSwitch.isOn)
    }

}
