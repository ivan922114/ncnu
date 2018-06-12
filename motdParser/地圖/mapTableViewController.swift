//
//  mapTableViewController.swift
//  motdParser
//
//  Created by viplab on 2018/6/12.
//  Copyright © 2018年 Seng Lam. All rights reserved.
//

import UIKit
import CoreLocation

class mapTableViewController: UITableViewController, XMLParserDelegate, CLLocationManagerDelegate {

    var places: [Place] = []
    var id: String = String()
    var lat: Double = Double()
    var lon: Double = Double()

    
    enum xmlTag: String {
        case node = "node"
        case id = "id"
        case lat = "lat"
        case lon = "lon"
    }
    enum xmlType: String {
        case parking = "parking"
        case toilets = "toilets"
    }
    var apiUrl: String = "http://www.overpass-api.de/api/xapi?*[amenity=\(xmlType.toilets.rawValue)][bbox=120.92246,23.9439,120.93623,23.9575]"
    var locationManager : CLLocationManager!
    func getDatas(apiUrl: String){
        let url = URL(string: apiUrl)
        let request = URLRequest(url: url!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            guard let data = data else {
                if let error = error {
                    print(error)
                }
                return
            }
            // Parse XML data
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
            OperationQueue.main.addOperation({
                self.tableView.reloadData()
            })
        })
        
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        getDatas(apiUrl: apiUrl)
        
    }
    
    var currentNodeName:String!
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currentNodeName = elementName
        if elementName == "node"{
            let place = Place()
            place.lat = atof(attributeDict["lat"])
            place.lon = atof(attributeDict["lon"])
            places.append(place)
    
        }
    }
    
//    func parser(_ parser: XMLParser, foundCharacters string: String) {
//        //2
//        let str = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//        if str != "" {
//            print("(currentNodeName):\(str)")
//        }
//    }
    
    var time = 0
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let curLocation:CLLocation = locations[0]
//        time += 1
//        print(time)
        locationManager.stopUpdatingLocation()
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
        return places.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = places[indexPath.row].id
        return cell
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
