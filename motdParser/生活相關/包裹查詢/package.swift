//
//  package.swift
//  motdParser
//
//  Created by Seng Lam on 2018/6/15.
//  Copyright © 2018年 Seng Lam. All rights reserved.
//

import Foundation
class Package{
    var company = String()
    var date = String()
    var department = String()
    var logID = String()
    var name = String()
    var recDay = String()
    var regNumber = String()
    var remark = String()
    var type = String()
    var dict:[String:String]{
        return ["company":company,
                "date":date,
                "department":department,
                "logID":logID,
                "name":name,
                "recDay":recDay,
                "regNumber":regNumber,
                "remark":remark,
                "type":type]
    }
}
