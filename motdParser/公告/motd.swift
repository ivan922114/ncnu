//
//  motd.swift
//  motdParser
//
//  Created by Seng Lam on 2018/5/2.
//  Copyright © 2018年 Seng Lam. All rights reserved.
//

import Foundation

struct Motd: Codable {
    var title: String = ""
    var publisher: String = ""
    var description: [String:String] = ["": ""]
    var email: String = ""
    var created_at: String = ""
    var publish_start_at: String = ""
    var publish_end_at: String = ""
    var Is_activity: Bool = false
    var activity_start_at: String = ""
    var activity_end_at: String = ""
    var activity_location: String = ""
    var category: String = ""
    
    
}
