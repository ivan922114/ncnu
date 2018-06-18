//
//  moreViewController.swift
//  motdParser
//
//  Created by viplab on 2018/6/15.
//  Copyright © 2018年 Seng Lam. All rights reserved.
//

import UIKit
import WebKit
class moreViewController: UIViewController, WKNavigationDelegate, UITableViewDelegate, UITableViewDataSource, URLSessionDataDelegate, MenuTransitionManagerDelegate{
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    let fullScreenSize = UIScreen.main.bounds.size
    var packages: [Package] = []
    var service = String()
    var Url = String()
    var Items: String = "最新消息"
    let menuTransitionManager = MenuTransitionManager()
    
    @IBOutlet var tableview: UITableView!
    
    func getData(packageURL: String){
        guard let packageUrl = URL(string: packageURL) else {
            return
        }
        let request = URLRequest(url: packageUrl)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print(error)
                return
            }
            // Parse JSON data
            if let data = data {
                self.packages = self.parseJsonData(data: data)
                // Reload table view
                OperationQueue.main.addOperation({
                    self.tableview.reloadData()
                })
            }
        })
        task.resume()
    }
    
    func parseJsonData(data: Data) -> [Package] {
        
        var packages = [Package]()
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:AnyObject]
            
            // Parse JSON data
            let jsonPackages = jsonResult?["items"] as? [AnyObject]
            for jsonPackage in jsonPackages! {
                let package = Package()
                package.company = jsonPackage["company"] as! String
                package.date = jsonPackage["date"] as! String
                package.department = jsonPackage["department"] as! String
                package.logID = jsonPackage["logID"] as! String
                package.name = jsonPackage["name"] as! String
                package.recDay = jsonPackage["recDay"] as! String
                package.regNumber = jsonPackage["regNumber"] as! String
                package.remark = jsonPackage["remark"] as! String
                package.type = jsonPackage["type"] as! String
                packages.append(package)
            }
        } catch {
            print(error)
        }
        return packages
    }
    
    func getWebView(url: String){
        let webView = UIWebView(frame: CGRect(x: 0, y: 0,width:fullScreenSize.width,height: fullScreenSize.height))
        webView.scalesPageToFit = true
        if let url = URL(string: Url) {
            let request = URLRequest(url: url)
            view.addSubview(webView)
            webView.loadRequest(request)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return packages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! moreViewCell
        
        cell.departmentLabel?.text = packages[indexPath.row].department
        cell.nameTextLabel?.text = packages[indexPath.row].name
        return cell
    }
    
    func setBG(img: String, width: CGFloat, height: CGFloat, alpha: CGFloat){
        let iv = UIImageView(image: UIImage(named: img))
        iv.contentMode = .scaleAspectFit
        iv.layer.frame = CGRect(x: tableview.bounds.midX-width/2, y: tableview.bounds.midY-height/2, width: width, height: height)
        let tableViewBackgroundView = UIView()
        tableViewBackgroundView.addSubview(iv)
        tableview.backgroundView = tableViewBackgroundView
        tableview.backgroundView?.alpha = alpha
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBG(img: "包裹", width: 256, height: 256, alpha: 0.03)
        
        
        switch service {
        case "校車時間":
            Url = "https://m.ncnu.edu.tw/MobileWeb/Home/bus"
            getWebView(url: Url)
        case "包裹查詢":
            Url = "http://cbooking.ddns.net/ncnu/package.php"
            getData(packageURL: Url)
            break
        case "汽機車登記":
            Url = "https://ccweb.ncnu.edu.tw/student/"
            getWebView(url: Url)
        case "緊急聯絡資訊":
            Url = "https://m.ncnu.edu.tw/MobileWeb/Home/phone"
            getWebView(url: Url)
        case "行事曆":
            let month = Calendar.current.component(.month, from: Date())
            var year = Calendar.current.component(.year, from: Date())-1912
            if(month > 7){
                year = year + 1
            }
            Url = "https://www.academic.ncnu.edu.tw/lesson/data/\(year)%E5%AD%B8%E5%B9%B4%E5%BA%A6%E8%A1%8C%E4%BA%8B%E6%9B%86.pdf"
            getWebView(url: Url)
        default:
            break
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPackageDetails"{
            if let indexPath = tableview.indexPathForSelectedRow{
                let destinationController = segue.destination as! packageDetailsTableViewController
                destinationController.package = packages[indexPath.row]
            }
        }
        if segue.identifier == "showPackageDepartment"{
            let destinationController = segue.destination as! packageMenuTableViewController
            destinationController.currentItem = navigationItem.title!
            destinationController.transitioningDelegate = menuTransitionManager
            menuTransitionManager.delegate = self
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        let sourceController = segue.source as! packageMenuTableViewController
        self.title = sourceController.currentItem
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
