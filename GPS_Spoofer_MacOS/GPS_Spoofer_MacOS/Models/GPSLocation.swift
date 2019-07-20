//
//  GPSLocation.swift
//  GPS_Spoofer_MacOS
//
//  Created by Kim SAVAROCHE on 20/07/2019.
//  Copyright © 2019 Kim SAVAROCHE. All rights reserved.
//

import Foundation

class GPSLocation {
    private var latitude: Double
    private var longitude: Double
    
    init() {
        latitude = 0
        longitude = 0
    }
    init(lat: Double, lon: Double) {
        latitude = lat
        longitude = lon
    }
    
    func setCoordinates(lat: Double, lon: Double) {
        latitude = lat
        longitude = lon
    }
    
    func setCoordinates(location: GPSLocation) {
        latitude = location.latitude
        longitude = location.longitude
    }
    
    func getLatitude() -> Double {
        return latitude
    }
    
    func getLongitude() -> Double {
        return longitude
    }
}
