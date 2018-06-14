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
    var name: String = String()
    var selectedIndex = Int()
    var distance = CLLocationDistance()
    var currentLocation = CLLocation()
    var apiUrl = String()
    var locationManager : CLLocationManager!
    
    func getDatas(apiUrl: String) {
        guard let apiUrl = URL(string: apiUrl) else {
            return
        }
        
        let request = URLRequest(url: apiUrl)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                let parser = XMLParser(data: data)
                parser.delegate = self
                parser.parse()
                // Reload table view
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                })
            }
        })
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "003"))
        self.tableView.backgroundView?.contentMode = .scaleAspectFill
        self.tableView.backgroundView?.alpha = 0.15
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        getDatas(apiUrl: apiUrl)
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        let currentNodeName = elementName
        switch currentNodeName {
        case "node":
            id = attributeDict["id"]!
            lat = atof(attributeDict["lat"])
            lon = atof(attributeDict["lon"])
            distance = currentLocation.distance(from: CLLocation(latitude: lat, longitude: lon))
        case "tag":
            if attributeDict["k"] == "name" && selectedIndex != 4{
                name = attributeDict["v"]!
            }else if selectedIndex == 4{
                if attributeDict["k"] == "name"{
                    name = attributeDict["v"]!
                }
            }else if selectedIndex == 3{
                if attributeDict["k"] == "operator"{
                    name = attributeDict["v"]!
                }
            }
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "node" {
            let place = Place()
            place.id = id
            place.lat = lat
            place.lon = lon
            place.distance = distance
            place.name = name
            places.append(place)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let curLocation:CLLocation = locations[0]
        currentLocation = curLocation
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
        places.sort(by: {$0.distance < $1.distance})
        if places[indexPath.row].name == ""{
            places[indexPath.row].name = navigationItem.title!
        }
        cell.textLabel?.text = places[indexPath.row].name
        cell.detailTextLabel?.text = "\(Int(places[indexPath.row].distance)) M"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showMapView":
            let destinationController = segue.destination as! mapViewController
            destinationController.navigationItem.title = "設施"
            destinationController.apiUrl = apiUrl
            destinationController.selectedIndex = selectedIndex
        case "showDetailView":
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationController = segue.destination as! mapDetailViewController
                destinationController.navigationItem.title = places[indexPath.row].name
                destinationController.lat = places[indexPath.row].lat
                destinationController.lon = places[indexPath.row].lon
                destinationController.name = places[indexPath.row].name
            }
        default:
            break
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
