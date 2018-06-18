//
//  packageMenuTableViewController.swift
//  motdParser
//
//  Created by viplab on 2018/6/18.
//  Copyright © 2018年 Seng Lam. All rights reserved.
//

import UIKit
class packageMenuTableViewController: UITableViewController {

    var menuItems = [""]
    var currentItem = "資工系"
    var i = 0
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
                self.menuItems = self.parseJsonData(data: data)
                // Reload table view
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                })
            }
        })
        task.resume()
    }
    
    func parseJsonData(data: Data) -> [String] {
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:AnyObject]
            
            // Parse JSON data
            if let jsonDepartments = jsonResult?["items"] as? [AnyObject]{
                for jsonDepartment in jsonDepartments {
                    if let depatment = jsonDepartment as? String{
                        if depatment != ""{
                            menuItems.append(depatment)
                        }
                    }
                }
            }
        } catch {
            print(error)
        }
        return menuItems
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for menuItem in menuItems{
            if menuItem == ""{
                menuItems.remove(at: i)
            }
            i += 1
        }
        getData(packageURL: "http://cbooking.ddns.net/ncnu/package.php?opt=department")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! packageMenuTableViewCell
        
        // Configure the cell...
        cell.titleLabel.text = menuItems[indexPath.row]
        cell.titleLabel.textColor = (menuItems[indexPath.row] == currentItem) ? UIColor.white : UIColor.gray
        
        return cell
    }
    
    // MARK: - segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let IndexPath = tableView.indexPathForSelectedRow{
            let menuTableViewController = segue.destination as! moreViewController
            currentItem = menuItems[IndexPath.row]
            menuTableViewController.Items = currentItem
            
            var urlComponents: URLComponents = URLComponents(string: "http://cbooking.ddns.net/ncnu/package.php?")!
            urlComponents.queryItems = [URLQueryItem(name: "opt", value: "getData"), URLQueryItem(name:"department", value:currentItem)]
            let url = urlComponents.string!
            menuTableViewController.getData(packageURL: url)
        }
    }
    
}
