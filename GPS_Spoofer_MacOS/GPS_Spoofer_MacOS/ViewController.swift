//
//  ViewController.swift
//  GPS_Spoofer_MacOS
//
//  Created by Kim SAVAROCHE on 20/07/2019.
//  Copyright © 2019 Kim SAVAROCHE. All rights reserved.
//

import Cocoa

let cities = [
    "London" : [51.507351, -0.127758],
    "Paris" : [48.856613, 2.352222],
    "Johannesburg" : [-26.204103, 28.047304],
    "Moscow" : [55.755825, 37.617298],
    "Mumbai" : [19.075983, 72.877655],
    "Tokyo" : [35.689487, 139.691711],
    "Kyoto" : [35.011635, 135.768036],
    "Kumamoto" : [32.803101, 130.707886],
    "Sydney" : [-33.868820, 151.209290],
    "Hong Kong" : [22.282150, 114.156890],
    "Honolulu" : [21.306944, -157.858337],
    "San Francisco" : [37.774929, -122.419418],
    "Mexico city" : [19.432608, -99.133209],
    "New York" : [40.712776, -74.005974],
    "Rio De Janeiro" : [-22.906847, -43.172897],
    "Bordeaux" : [44.837788, -0.579180],
    "Agen" : [44.201408, 0.611980]
]
let citiesKeys = Array(cities.keys).sorted(by: <)

class ViewController: NSViewController {
    @IBOutlet weak var citySelector: NSPopUpButton!
    @IBOutlet weak var latitudeText: NSTextField!
    @IBOutlet weak var longitudeText: NSTextField!
    @IBOutlet weak var terminal: NSScrollView!
    
    var gpxFile = GPXFile(name: "gps_location", ext: "gpx")
    var gpsLocation = GPSLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCities()
        
        gpxFile.load(gpsLocation: &gpsLocation)
        showCoordinates()
    }
    
    func showCoordinates() {
        latitudeText.stringValue = String(format:"%f", gpsLocation.getLatitude())
        longitudeText.stringValue = String(format:"%f", gpsLocation.getLongitude())
    }
    
    func loadCities() {
        citySelector.removeAllItems()
        
        for name in citiesKeys {
            citySelector.addItem(withTitle: name)
        }
    }
    
    // MARK: - Buttons actions
    
    @IBAction func ApplyTouched(_ sender: Any) {
        print("ApplyTouched")
    }
    
    
    @IBAction func SaveTouched(_ sender: Any) {
        print("SaveTouched")
    }
}

