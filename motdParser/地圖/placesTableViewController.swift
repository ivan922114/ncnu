//
//  placesTableViewController.swift
//  motdParser
//
//  Created by viplab on 2018/6/13.
//  Copyright © 2018年 Seng Lam. All rights reserved.
//

import UIKit

class placesTableViewController: UITableViewController {

    enum placeType: String {
        case parking = "http://www.overpass-api.de/api/xapi?node[amenity=parking][bbox=120.92246,23.9439,120.93623,23.9575]"
        case toilets = "http://www.overpass-api.de/api/xapi?node[amenity=toilets][bbox=120.92246,23.9439,120.93623,23.9575]"
        case drinking_water = "http://www.overpass-api.de/api/xapi?node[amenity=drinking_water][bbox=120.92246,23.9439,120.93623,23.9575]"
        case atm = "http://www.overpass-api.de/api/xapi?node[amenity=atm][bbox=120.92246,23.9439,120.93623,23.9575]"
        case busStop = "http://www.overpass-api.de/api/xapi?node[network=%E6%9A%A8%E5%A4%A7%E4%BA%A4%E9%80%9A%E8%BB%8A][bbox=120.92188,23.94296,120.98162,23.97198]"
    }
    
    var placetype:[String:String] = ["停車場":placeType.parking.rawValue,"廁所":placeType.toilets.rawValue,"飲水機":placeType.drinking_water.rawValue,"提款機":placeType.atm.rawValue,"校車站":placeType.busStop.rawValue]
    var place = ["停車場","廁所","飲水機","提款機","校車站"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isHidden = false
//        navigationController?.navigationBar.prefersLargeTitles = false
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "013"))
        self.tableView.backgroundView?.contentMode = .scaleAspectFill
        self.tableView.backgroundView?.alpha = 0.15
        
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
        return place.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! placesTableViewCell
        cell.placeImageView.image = UIImage(named: place[indexPath.row])
        cell.placeLabel?.text = place[indexPath.row]
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlaces"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationController = segue.destination as! mapTableViewController
                destinationController.navigationItem.title = place[indexPath.row]
                destinationController.apiUrl = placetype[place[indexPath.row]]!
                destinationController.selectedIndex = indexPath.row
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
