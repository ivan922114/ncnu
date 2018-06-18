//
//  packageMenuTableViewController.swift
//  motdParser
//
//  Created by viplab on 2018/6/18.
//  Copyright © 2018年 Seng Lam. All rights reserved.
//

import UIKit
class packageMenuTableViewController: UITableViewController {

    var menuItems = ["中文系", "資工系", "應化系"]
    var currentItem = "中文系"
    var i = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Set(menuItems).count != menuItems.count{
            menuItems = Array(Set(menuItems))
        }
        for menuItem in menuItems{
            if menuItem == ""{
                menuItems.remove(at: i)
            }
            i += 1
        }
        menuItems.sort()
        print(menuItems)
        
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
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let menuTableViewController = segue.source as! packageDetailsTableViewController
        if let selectedIndexPath = menuTableViewController.tableView.indexPathForSelectedRow{
            currentItem = menuItems[selectedIndexPath.row]
        }
    }
    
}
