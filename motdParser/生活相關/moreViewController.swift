//
//  moreViewController.swift
//  motdParser
//
//  Created by viplab on 2018/6/15.
//  Copyright © 2018年 Seng Lam. All rights reserved.
//

import UIKit
import WebKit
class moreViewController: UIViewController, WKNavigationDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = "123"
        
        return cell
    }
    
    
    @IBOutlet var webView: UIWebView!
    var service = String()
    var Url = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        switch service {
        case "校車時間":
            Url = "https://www.doc.ncnu.edu.tw/affairs/index.php/2012-07-11-07-39-40/category/11-2012-07-12-01-50-48?download=323:106-2-107-2-24-107-7-1"
            print(service)
        case "包裹查詢":
            //Url = "http://ccweb.ncnu.edu.tw/dormMail/"
            //print(service)
            break
        case "汽機車登記":
            Url = "https://ccweb.ncnu.edu.tw/student/"
            print(service)
        case "緊急聯絡資訊":
            Url = "https://m.ncnu.edu.tw/MobileWeb/Home/phone"
            print(service)
        default:
            break
        }
        
        if let url = URL(string: Url) {
            let request = URLRequest(url: url)
            self.view.addSubview(webView)
            webView.loadRequest(request)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
