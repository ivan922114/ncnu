//
//  PlaceViewController.swift
//  motdParser
//
//  Created by Seng Lam on 2018/6/13.
//  Copyright © 2018年 Seng Lam. All rights reserved.
//

import UIKit
import GoogleMaps
class PlaceViewController: UIViewController, GMSMapViewDelegate{

    @IBOutlet var panoramaView: GMSPanoramaView!
    override func viewDidLoad() {
        super.viewDidLoad()

        panoramaView.moveNearCoordinate(CLLocationCoordinate2D(latitude: 37.3317134, longitude: -122.0307466))
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
