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
        return ["收件人姓名":name,
                "可能系級":department,
                "收件日期":date,
                "郵寄公司":company,
                "掛號號碼":regNumber,
                "收件天數":recDay,
                "logID ":logID,
                "種類":type,
                "備註":remark]
    }
}
