//
//  GPXFile.swift
//  GPS_Spoofer_MacOS
//
//  Created by Kim SAVAROCHE on 20/07/2019.
//  Copyright © 2019 Kim SAVAROCHE. All rights reserved.
//

import Foundation

class GPXFile: NSObject, XMLParserDelegate {
    private let coordinatesKey = "wpt"
    private let latitudeKey = "lat"
    private let longitudeKey = "lon"
    private var gpxfilePath = ""
    private var loadedLocation = GPSLocation()
    
    
    // MARK: - Load GPS Location from gpx file
    
    func load(filePath: String, gpsLocation: inout GPSLocation) {
        gpxfilePath = filePath
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: gpxfilePath) {
            if let parser = XMLParser(contentsOf: URL(fileURLWithPath: gpxfilePath) ) {
                parser.delegate = self
                parser.parse()
            }
            gpsLocation.setCoordinates(location: loadedLocation)
        } else {
            print("ERROR - could not load ", filePath)
        }
        
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == coordinatesKey {
            let lat = Double(attributeDict[latitudeKey]!)!
            let lon = Double(attributeDict[longitudeKey]!)!
            loadedLocation.setCoordinates(lat: lat, lon: lon)
        }
    }
    
    func saveCoordinates(coordinates: GPSLocation) {
        var xmlString = ""
        xmlString.append(contentsOf: "<?xml version=\"1.0\"?>\n")
        xmlString.append(contentsOf: "<gpx version=\"1.1\" creator=\"Xcode\">\n" )
        xmlString.append(contentsOf: "\t<wpt lat=\"\(String(coordinates.getLatitude()))\" lon=\"\(String(coordinates.getLongitude()))\">\n" )
        xmlString.append(contentsOf: "\t\t<name>ALocation</name>\n" )
        xmlString.append(contentsOf: "\t\t<time>2014-09-24T14:55:37Z</time>\n" )
        xmlString.append(contentsOf: "\t</wpt>\n" )
        xmlString.append(contentsOf: "</gpx>\n" )
        
        do {
            try xmlString.write(to: URL(fileURLWithPath: gpxfilePath) , atomically: false, encoding: .utf8)
            print("Coordinates saved in ", gpxfilePath)
        }
        catch {
            print("ERROR - could not save coordinates in ", gpxfilePath, ": ", error)
        }
    }
}
