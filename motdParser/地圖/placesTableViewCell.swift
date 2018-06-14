//
//  placesTableViewCell.swift
//  motdParser
//
//  Created by viplab on 2018/6/13.
//  Copyright © 2018年 Seng Lam. All rights reserved.
//

import UIKit

class placesTableViewCell: UITableViewCell {
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
