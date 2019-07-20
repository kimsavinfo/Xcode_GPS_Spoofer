//
//  ViewController.swift
//  GPS_Spoofer_MacOS
//
//  Created by Kim SAVAROCHE on 20/07/2019.
//  Copyright © 2019 Kim SAVAROCHE. All rights reserved.
//

import Cocoa


class ViewController: NSViewController, XMLParserDelegate {
    var gpsLocation:GPSLocation = GPSLocation()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGPSLocation()
    }

    // MARK: - Load GPS Location from gpx file
    
    func loadGPSLocation() {
        
        if let path = Bundle.main.url(forResource: "gps_location", withExtension: "gpx") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        } else {
            print("ERROR - gps_location.gpx path not found")
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "wpt" {
            let lat = Double(attributeDict["lat"]!)!
            let lon = Double(attributeDict["lon"]!)!
            gpsLocation.setCoordinates(lat: lat, lon: lon)
        }
    }
}

