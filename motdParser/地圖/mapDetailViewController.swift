//
//  mapDetailViewController.swift
//  motdParser
//
//  Created by Seng Lam on 2018/6/13.
//  Copyright © 2018年 Seng Lam. All rights reserved.
//

import UIKit
import GoogleMaps

class mapDetailViewController: UIViewController, GMSMapViewDelegate,CLLocationManagerDelegate{

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet var panoramaView: GMSPanoramaView!
    
//    var locationManager : CLLocationManager!
    var lat = Double()
    var lon = Double()
    var name = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // mapview
        let marker = GMSMarker()
        mapView.camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 16.5)
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.settings.scrollGestures = false
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        marker.icon = GMSMarker.markerImage(with: .red)
        marker.appearAnimation = GMSMarkerAnimation.pop
        marker.map = mapView
        marker.snippet = "\(name)"
        
        // panoView
        panoramaView.moveNearCoordinate(CLLocationCoordinate2D(latitude: lat, longitude: lon))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
