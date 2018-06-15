//
//  moreTableViewCell.swift
//  motdParser
//
//  Created by viplab on 2018/6/15.
//  Copyright © 2018年 Seng Lam. All rights reserved.
//

import UIKit

class moreTableViewCell: UITableViewCell {

    @IBOutlet var tilteImage: UIImageView!
    @IBOutlet var tilteText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
