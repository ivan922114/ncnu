//
//  motdDetailsTitleTableViewCell
//  motdParser
//
//  Created by Seng Lam on 2018/6/17.
//  Copyright © 2018年 Seng Lam. All rights reserved.
//

import UIKit

class motdDetailsTitleTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
