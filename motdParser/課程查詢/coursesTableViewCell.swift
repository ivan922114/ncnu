//
//  coursesTableViewCell.swift
//  xmltest
//
//  Created by Seng Lam on 2018/5/30.
//  Copyright © 2018年 Seng Lam. All rights reserved.
//

import UIKit

class coursesTableViewCell: UITableViewCell {
    
    @IBOutlet var time :UILabel!
    @IBOutlet var teacher :UILabel!
    @IBOutlet var course :UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
