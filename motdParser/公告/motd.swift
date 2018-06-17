//
//  motd.swift
//  motdParser
//
//  Created by Seng Lam on 2018/5/2.
//  Copyright © 2018年 Seng Lam. All rights reserved.
//

import Foundation

struct Motd: Codable {
    var title = ""
    var publisher = ""
    var description = ["" : ""]
    var attach_files = ["" : ""]
    var email = ""
    var created_at = ""
    var publish_start_at = ""
    var publish_end_at = ""
    var Is_activity = false
    var activity_start_at = ""
    var activity_end_at = ""
    var activity_location = ""
    var category = ""
    
    
}
