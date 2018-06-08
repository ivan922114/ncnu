//
//  motdTableViewCell.swift
//  motdParser
//
//  Created by Seng Lam on 2018/5/2.
//  Copyright © 2018年 Seng Lam. All rights reserved.
//

import UIKit

class motdTableViewCell: UITableViewCell {

    @IBOutlet var title :UILabel!
    @IBOutlet var category :UILabel!
//    @IBOutlet var descript :UIWebView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
