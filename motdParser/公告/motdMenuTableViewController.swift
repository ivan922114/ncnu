//
//  motdMenuTableViewController.swift
//  motdParser
//
//  Created by viplab on 2018/5/16.
//  Copyright © 2018年 Seng Lam. All rights reserved.
//

import UIKit

class motdMenuTableViewController: UITableViewController {

    var menuItems = ["最新消息"]
    var currentItem = "最新消息"
    var i=0
    
    
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
        print(menuItems)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! motdMenuTableViewCell

        // Configure the cell...
        cell.titleLabel.text = menuItems[indexPath.row]
        cell.titleLabel.textColor = (menuItems[indexPath.row] == currentItem) ? UIColor.darkGray : UIColor.darkText

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let IndexPath = tableView.indexPathForSelectedRow{
            let menuTableViewController = segue.destination as! motdTableViewController
                currentItem = menuItems[IndexPath.row]
                menuTableViewController.Items = currentItem
                menuTableViewController.getLatestMotds()
        }
    }
}
