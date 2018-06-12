//
//  mapViewController.swift
//  motdParser
//
//  Created by Seng Lam on 2018/6/8.
//  Copyright © 2018年 Seng Lam. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import GoogleMaps

class mapViewController: UIViewController,XMLParserDelegate,GMSMapViewDelegate,CLLocationManagerDelegate{
    
//    enum xmlTag: String {
//        case node = "node"
//        case id = "id"
//        case lat = "lat"
//        case lon = "lon"
//    }
    
    enum xmlType: String {
        case parking = "parking"
        case toilets = "toilets"
    }
    
    var apiUrl: String = "http://www.overpass-api.de/api/xapi?*[amenity=\(xmlType.toilets.rawValue)][bbox=120.92246,23.9439,120.93623,23.9575]"
    
    @IBOutlet weak var SegmentedControl: UISegmentedControl!
    @IBOutlet weak var map: GMSMapView!
    @IBAction func clearBtn(_ sender: Any) {
        let camera = GMSCameraPosition.camera(withLatitude: 23.9504, longitude: 120.9299, zoom: 16.5)
        map.camera = camera
        self.map.clear()
    }

    @IBAction func indexChanged(_ sender: Any) {
        switch SegmentedControl.selectedSegmentIndex
        {
        case 0:
            apiUrl = "http://www.overpass-api.de/api/xapi?*[name=%E6%A0%A1%E8%BB%8A%E7%AB%99%E7%89%8C][bbox=120.92246,23.9439,120.93623,23.9575]"
            print("busStop")
            getData(apiUrl: apiUrl)
            
        case 1:
            apiUrl = "http://www.overpass-api.de/api/xapi?*[amenity=\(xmlType.toilets.rawValue)][bbox=120.92246,23.9439,120.93623,23.9575]"
            print("toilets")
            getData(apiUrl: apiUrl)
        case 2:
            apiUrl = "http://www.overpass-api.de/api/xapi?*[amenity=\(xmlType.parking.rawValue)][bbox=120.92246,23.9439,120.93623,23.9575]"
            print("parking")
            getData(apiUrl: apiUrl)
        default:
            break
        }
    }
    
    var locationManager : CLLocationManager!
    
    func getData(apiUrl: String){
        do{
            let url = URL(string: apiUrl)
            let data = try Data(contentsOf: url!)
            // Parse XML data
            map.clear()
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }catch{
            print("error")
        }
    }
    
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
            
        })
        
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //corelocation
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // mapview
        getData(apiUrl: apiUrl)
        let camera = GMSCameraPosition.camera(withLatitude: 23.9504, longitude: 120.9299, zoom: 16.5)
        map.camera = camera
        map.layer.borderWidth = 2
        map.layer.borderColor = UIColor.black.cgColor
        map.settings.compassButton = true
        map.settings.myLocationButton = true
        map.isMyLocationEnabled = true
        map.delegate = self
//        map.padding = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 50)
        
    }
    
    var currentNodeName:String!
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currentNodeName = elementName
        if elementName == "node"{
            let lat:Double = atof(attributeDict["lat"])
            let lon:Double = atof(attributeDict["lon"])
            let marker = GMSMarker()
            marker.map = map
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            marker.snippet = "Hello World!"
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
        self.map.camera = GMSCameraPosition.camera(withLatitude: curLocation.coordinate.latitude, longitude: curLocation.coordinate.longitude, zoom: 16.5)
        //        let myLocation = GMSMarker()
        //        myLocation.position = CLLocationCoordinate2D(latitude: curLocation.coordinate.latitude, longitude: curLocation.coordinate.longitude)
        //        myLocation.icon = GMSMarker.markerImage(with: .blue)
        //        myLocation.appearAnimation = GMSMarkerAnimation.pop
        //        myLocation.map = map
        //        map.clear()
        time += 1
        print(time)
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
