//
//  departmentTableViewController.swift
//  xmltest
//
//  Created by Seng Lam on 2018/5/30.
//  Copyright © 2018年 Seng Lam. All rights reserved.
//

import UIKit

class departmentTableViewController: UITableViewController {
    
    var departmentID = ["中文系":"M100","外文系":"M200","社工系":"M400","公行系":"M500","歷史系":"M600","東南亞系":"M800","華文碩士學程":"MD00","非營利組織經營管理碩士學位學程":"MF00","原鄉發展學士專班":"MG00","國企系":"N100","經濟系":"N200","資管系":"N300","財金系":"N400","觀光餐旅系":"N500","管理學學位學程":"N600","新興產業策略與發展學位學程":"N800","土木系":"O100","資工系":"O200","電機系":"O300","應化系":"O400","應光系":"O800","國比系":"M300","教政系":"M700","諮人系":"MA00","課科所":"MC00","終身學習與人資專班":"ME00","其他":"U000"]
    var department: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "011"))
        self.tableView.backgroundView?.contentMode = .scaleAspectFill
        self.tableView.backgroundView?.alpha = 0.15
        
        let sortedDepartment = departmentID.sorted { first, second in
            return first.1 < second.1
        }
        for (key,_) in sortedDepartment{
            department.append(key)
        }
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
        return departmentID.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = department[indexPath.row]

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCourses"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationController = segue.destination as! TableViewController
                destinationController.navigationItem.title = department[indexPath.row]
                destinationController.dpID = departmentID[department[indexPath.row]]!
                
            }
        }
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
