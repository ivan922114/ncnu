//
//  mapViewController.swift
//  motdParser
//
//  Created by Seng Lam on 2018/6/8.
//  Copyright © 2018年 Seng Lam. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class mapViewController: UIViewController,XMLParserDelegate,GMSMapViewDelegate,CLLocationManagerDelegate{
    
    var apiUrl: String = String()
    var time = 0
    var selectedIndex = Int()
    var locationManager : CLLocationManager!
    
    @IBOutlet weak var SegmentedControl: UISegmentedControl!
    @IBOutlet weak var mapView: GMSMapView!
    @IBAction func clearBtn(_ sender: Any) {
        let camera = GMSCameraPosition.camera(withLatitude: 23.9504, longitude: 120.9299, zoom: 16.5)
        mapView.camera = camera
        self.mapView.clear()
    }

    @IBAction func indexChanged(_ sender: Any) {
        switch SegmentedControl.selectedSegmentIndex {
        case 0:
            apiUrl = "http://www.overpass-api.de/api/xapi?node[amenity=parking][bbox=120.92246,23.9439,120.93623,23.9575]"
            getDatas(apiUrl: apiUrl)
        case 1:
            apiUrl = "http://www.overpass-api.de/api/xapi?node[amenity=toilets][bbox=120.92246,23.9439,120.93623,23.9575]"
            getDatas(apiUrl: apiUrl)
        case 2:
            apiUrl = "http://www.overpass-api.de/api/xapi?node[amenity=drinking_water][bbox=120.92246,23.9439,120.93623,23.9575]"
            getDatas(apiUrl: apiUrl)
        case 3:
            apiUrl = "http://www.overpass-api.de/api/xapi?node[amenity=atm][bbox=120.92246,23.9439,120.93623,23.9575]"
            getDatas(apiUrl: apiUrl)
        case 4:
            apiUrl = "http://www.overpass-api.de/api/xapi?node[network=%E6%9A%A8%E5%A4%A7%E4%BA%A4%E9%80%9A%E8%BB%8A][bbox=120.92188,23.94296,120.98162,23.97198]"
            getDatas(apiUrl: apiUrl)
        default:
            break
        }
    }
    
//    func getData(apiUrl: String){
//        do{
//            let url = URL(string: apiUrl)
//            let data = try Data(contentsOf: url!)
//            // Parse XML data
//            mapView.clear()
//            let parser = XMLParser(data: data)
//            parser.delegate = self
//            parser.parse()
//        }catch{
//            print("error")
//        }
//    }
    
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
            self.mapView.clear()
            self.places.removeAll()
            let parser = XMLParser(data: data)

            parser.delegate = self
            parser.parse()

            for place in self.places{
                let marker = GMSMarker()
                marker.map = self.mapView
                marker.position = CLLocationCoordinate2D(latitude: place.lat, longitude: place.lon)
                marker.snippet = place.name
            }
        })
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SegmentedControl.selectedSegmentIndex = selectedIndex
        
        // corelocation
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // mapview
        getDatas(apiUrl: apiUrl)
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
    }
    
    var places: [Place] = []
    var id = String()
    var lat = Double()
    var lon = Double()
    var name = String()
    var distance = CLLocationDistance()
    var currentLocation = CLLocation()
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        let currentNodeName = elementName
        switch currentNodeName {
        case "node":
            id = attributeDict["id"]!
            lat = atof(attributeDict["lat"])
            lon = atof(attributeDict["lon"])
            distance = currentLocation.distance(from: CLLocation(latitude: lat, longitude: lon))
        case "tag":
            if attributeDict["k"] == "name"{
                name = attributeDict["v"]!
            }else if attributeDict["k"] == "amenity"{
                name = "飲水機"
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
        let curLat = locations[0].coordinate.latitude
        let curLon = locations[0].coordinate.longitude
        self.mapView.camera = GMSCameraPosition.camera(withLatitude: curLat, longitude: curLon, zoom: 16.5)
        locationManager.stopUpdatingLocation()
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("show new view")
    }
    
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
        print("You tapped \(name): \(placeID),\(location.latitude)/\(location.longitude)")
        let infoMarker = GMSMarker()
        infoMarker.snippet = placeID
        infoMarker.position = location
        infoMarker.title = name
        infoMarker.opacity = 0;
        infoMarker.infoWindowAnchor.y = 1
        infoMarker.map = mapView
        mapView.selectedMarker = infoMarker
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
}
