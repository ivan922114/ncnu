//
//  motdDetailsViewController.swift
//  motdParser
//
//  Created by Seng Lam on 2018/6/18.
//  Copyright © 2018年 Seng Lam. All rights reserved.
//

import UIKit
import WebKit

class motdDetailsViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var webView: WKWebView!
    
    var motd = Motd()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = motd.title
        dateLabel.text = motd.created_at
        configure()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configure(){
        var dscription = String()
        if motd.description["#cdata-section"]! != ""{
            dscription = motd.description["#cdata-section"]!
        }
        
        let base = dscription
        webView.loadHTMLString(base, baseURL: nil)
        webView.navigationDelegate = self
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
