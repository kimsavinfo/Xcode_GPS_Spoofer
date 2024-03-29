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
    private let distanceFactor = 0.00005
    
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
    
    func moveLatitude(up: Bool, speed: Double) {
        if(up) {
            latitude += distanceFactor
        } else {
            latitude -= distanceFactor
        }
    }
    
    func moveLongitude(left: Bool, speed: Double) {
        if(left) {
            longitude += distanceFactor
        } else {
            longitude -= distanceFactor
        }
    }
}
