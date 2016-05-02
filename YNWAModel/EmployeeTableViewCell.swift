//
//  EmployeeTableViewCell.swift
//  YNWAModel
//
//  Created by iosdev on 21.4.2016.
//  Copyright © 2016 thanhbinhtran. All rights reserved.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var beaconAccuracyLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
