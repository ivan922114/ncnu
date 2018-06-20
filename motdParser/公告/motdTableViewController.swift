//
//  motdTableViewController.swift
//  motdParser
//
//  Created by Seng Lam on 2018/5/2.
//  Copyright © 2018年 Seng Lam. All rights reserved.
//

import UIKit

@objc protocol MenuTransitionManagerDelegate {
    func dismiss()
}

class motdTableViewController: UITableViewController, MenuTransitionManagerDelegate {

    var Items: String = "最新消息"
    var category = [""]
    
    let menuTransitionManager = MenuTransitionManager()
    var delegate: MenuTransitionManagerDelegate?
    
    let motdURL = "https://api.ncnu.edu.tw/API/get.aspx?json=info_ncnu&month_include=1"
    var motds = [Motd]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Items
//        tableView.estimatedRowHeight = 160.0
//        tableView.rowHeight = UITableViewAutomaticDimension
        self.navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isHidden = false
//        navigationController?.navigationBar.prefersLargeTitles = false
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "011"))
        self.tableView.backgroundView?.contentMode = .scaleAspectFill
        self.tableView.backgroundView?.alpha = 0.1
        
        refreshControl?.addTarget(self, action: #selector(motdTableViewController.getLatestMotds), for: UIControlEvents.valueChanged)
        getLatestMotds()
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
        return motds.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! motdTableViewCell
        
        // Configure the cell...
        switch motds[indexPath.row].category {
        case Items:
            cell.title.text = motds[indexPath.row].title
            cell.date.text = motds[indexPath.row].created_at
            return cell
            
        default:
            break
        }
        
        return cell
    }
    
    // MARK: - Helper methods
    
    @objc func getLatestMotds() {
        guard let motdUrl = URL(string: motdURL) else {
            return
        }
        
        let request = URLRequest(url: motdUrl)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if let error = error {
                print(error)
                return
            }
            
            // Parse JSON data
            if let data = data {
                self.motds = self.parseJsonData(data: data)
                
                // Reload table view
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                })
            }
        })
        
        task.resume()
    }
    
    func parseJsonData(data: Data) -> [Motd] {
        
        var motds = [Motd]()
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:[String:AnyObject]]
           
            // Parse JSON data
            if let jsonMotds = jsonResult?["info_ncnu"]?["item"] as? [AnyObject]{
                for jsonMotd in jsonMotds {
                    var motd = Motd()
                    if jsonMotd["category"] as! String != "" {
                        category.append(jsonMotd["category"] as! String)
                    }
                    if jsonMotd["category"] as! String == Items{
                        motd.title = jsonMotd["title"] as! String
                        motd.publisher = jsonMotd["publisher"] as! String
                        motd.category = jsonMotd["category"] as! String
                        motd.created_at = jsonMotd["created_at"] as! String
                        if let jsonDescription = jsonMotd["description"] as? [String:String]{
                            motd.description = jsonDescription["#cdata-section"]!
                        }
                        if let jsonAttachs = jsonMotd["attach_files"] as? [String: AnyObject]{
                            for (_,value) in jsonAttachs{
                                if let attach_name = value["@attach_name"]{
                                    if motd.attach_name[0] != ""{
                                        motd.attach_name.append(attach_name as! String)
                                    }else{
                                        motd.attach_name[0] = attach_name as! String
                                    }
                                }
                                if let attach_url = value["@attach_url"]{
                                    if motd.attach_url[0] != ""{
                                        motd.attach_url.append(attach_url as! String)
                                    }else{
                                        motd.attach_url[0] = attach_url as! String
                                    }
                                }
                                if let attach_size = value["@attach_size"]{
                                    if motd.attach_size[0] != ""{
                                        motd.attach_size.append(attach_size as! String)
                                    }else{
                                        motd.attach_size[0] = attach_size as! String
                                    }
                                }
                            }
                        }
                        motds.append(motd)
                    }
                    
                }
            }
        } catch {
            print(error)
        }
        
        return motds
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMotdDetails" {
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationController = segue.destination as! motdDetailsViewController
                destinationController.motd = motds[indexPath.row]
            }
        }
        if segue.identifier == "gotomotdTable" {
            let menuTableViewController = segue.destination as! motdMenuTableViewController
            menuTableViewController.currentItem = self.title!
            menuTableViewController.transitioningDelegate = menuTransitionManager
            menuTransitionManager.delegate = self
            menuTableViewController.menuItems = category
        }
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        let sourceController = segue.source as! motdMenuTableViewController
        self.title = sourceController.currentItem
    }
    
    // MARK: - MenuTransitionManagerDelegate methods
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
