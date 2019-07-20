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
    private var fileName = ""
    private var fileExtension = ""
    private var loadedLocation = GPSLocation()
    
    init(name: String, ext: String) {
        fileName = name
        fileExtension = ext
    }
    
    // MARK: - Load GPS Location from gpx file
    
    func load(gpsLocation: inout GPSLocation) {
        if let path = Bundle.main.url(forResource: fileName, withExtension: fileExtension) {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
            gpsLocation.setCoordinates(location: loadedLocation)
        } else {
            print("ERROR - ", fileName, ".", fileExtension , " path not found")
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
        xmlString.append(contentsOf: "\t\t<name>Cupertino</name>\n" )
        xmlString.append(contentsOf: "\t\t<time>2014-09-24T14:55:37Z</time>\n" )
        xmlString.append(contentsOf: "\t</wpt>\n" )
        xmlString.append(contentsOf: "</gpx>\n" )
        
        let path = "/\(fileName).\(fileExtension)"
        do {
            try xmlString.write(to: URL(fileURLWithPath: path) , atomically: false, encoding: .utf8)
            print("write in  ", path)
        }
        catch {
            print("ERROR - saving coordinates in ", fileName, ".", fileExtension, ": ", error)
        }
    }
}
