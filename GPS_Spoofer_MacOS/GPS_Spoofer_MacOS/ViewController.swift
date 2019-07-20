//
//  ViewController.swift
//  GPS_Spoofer_MacOS
//
//  Created by Kim SAVAROCHE on 20/07/2019.
//  Copyright © 2019 Kim SAVAROCHE. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    var gpxFile = GPXFile(name: "gps_location", ext: "gpx")
    var gpsLocation = GPSLocation()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gpxFile.load(gpsLocation: &gpsLocation)
        
        print(gpsLocation.latitude , " " , gpsLocation.longitude)
    }
    
}

