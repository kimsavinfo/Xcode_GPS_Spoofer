//
//  ViewController.swift
//  GPS_Spoofer_MacOS
//
//  Created by Kim SAVAROCHE on 20/07/2019.
//  Copyright © 2019 Kim SAVAROCHE. All rights reserved.
//

import Cocoa

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
    
    func loadCities() {
        citySelector.removeAllItems()
        
        for name in citiesKeys {
            citySelector.addItem(withTitle: name)
        }
    }
    
    // MARK: - Coordinates actions
    
    func saveCoordinates() {
        gpxFile.saveCoordinates(coordinates: gpsLocation)
    }
    
    func showCoordinates() {
        latitudeText.stringValue = String(format:"%f", gpsLocation.getLatitude())
        longitudeText.stringValue = String(format:"%f", gpsLocation.getLongitude())
    }
    
    // MARK: - Buttons actions
    
    @IBAction func ApplyTouched(_ sender: Any) {
        let key = citySelector.titleOfSelectedItem
        let coordinates = cities[key!]
        gpsLocation.setCoordinates(lat: coordinates![0], lon: coordinates![1])
        
        saveCoordinates()
        showCoordinates()
    }
    
    
    @IBAction func SaveTouched(_ sender: Any) {
        saveCoordinates()
    }
}

