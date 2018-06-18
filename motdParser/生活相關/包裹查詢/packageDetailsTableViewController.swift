//
//  packageDetailsTableViewController.swift
//  motdParser
//
//  Created by Seng Lam on 2018/6/16.
//  Copyright © 2018年 Seng Lam. All rights reserved.
//

import UIKit

@objc protocol packageMenuTransitionManagerDelegate {
    func dismiss()
}

class packageDetailsTableViewController: UITableViewController, packageMenuTransitionManagerDelegate {
    
    let menuTransitionManager = MenuTransitionManager()
    var delegate: packageMenuTransitionManagerDelegate?
    
    var package = Package()
    var arrKey: [String] = Array()
    var arrValue: [String] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "包裹查詢"
        
        setBG(img: "包裹", width: 256, height: 256, alpha: 0.03)
        for (key,value) in package.dict {
            arrKey.append(key)
            arrValue.append(value)
        }
    }

    func setBG(img: String, width: CGFloat, height: CGFloat, alpha: CGFloat){
        let iv = UIImageView(image: UIImage(named: img))
        iv.contentMode = .scaleAspectFit
        iv.layer.frame = CGRect(x: tableView.bounds.midX-width/2, y: tableView.bounds.midY-height/2, width: width, height: height)
        let tableViewBackgroundView = UIView()
        tableViewBackgroundView.addSubview(iv)
        tableView.backgroundView = tableViewBackgroundView
        tableView.backgroundView?.alpha = alpha
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrKey.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! packageDetailsTableViewCell
        
        cell.keyLabel.text = arrKey[indexPath.row]
        cell.valueLabel.text = arrValue[indexPath.row]
        return cell
    }

    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPackageDepartment" {
            let menuTableViewController = segue.destination as! motdMenuTableViewController
            menuTableViewController.currentItem = self.title!
            menuTableViewController.transitioningDelegate = menuTransitionManager
            menuTransitionManager.delegate = self
//            menuTableViewController.menuItems = category
        }
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        let sourceController = segue.source as! packageMenuTableViewController
        self.title = sourceController.currentItem
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
