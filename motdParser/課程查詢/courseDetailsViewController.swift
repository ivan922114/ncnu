//
//  courseDetailsViewController.swift
//  xmltest
//
//  Created by Seng Lam on 2018/5/30.
//  Copyright © 2018年 Seng Lam. All rights reserved.
//

import UIKit
import WebKit

class courseDetailsViewController: UIViewController,  WKNavigationDelegate{
    
    @IBOutlet var detail: WKWebView!
    var id = ""
    var `class` = ""
    var link :String = "https://ccweb.ncnu.edu.tw/student/aspmaker_course_opened_detail_viewview.php?showdetail=&year=1062&courseid="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false

        // Do any additional setup after loading the view.
        link += id + "&class="
        link += `class` + "&modal=2"
        print(link)
        let url = URL(string: link)
        let request = URLRequest(url: url!)
        detail.load(request)
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
