//
//  ViewController.swift
//  GPS_Spoofer_MacOS
//
//  Created by Kim SAVAROCHE on 20/07/2019.
//  Copyright © 2019 Kim SAVAROCHE. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var pathLabel: NSTextField!
    @IBOutlet weak var citySelector: NSPopUpButton!
    @IBOutlet weak var latitudeText: NSTextField!
    @IBOutlet weak var longitudeText: NSTextField!
    @IBOutlet weak var terminal: NSScrollView!
    @IBOutlet weak var applyButton: NSButton!
    @IBOutlet weak var saveButton: NSButton!
    
    let gpxPathKey = "gpxPath"
    var gpxFile = GPXFile()
    var gpsLocation = GPSLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCities()
        
        var enable = false
        loadUserSettings(enableElements: &enable)
        setElements(isEnabled: enable)
    }

    func loadCities() {
        citySelector.removeAllItems()
        
        for name in citiesKeys {
            citySelector.addItem(withTitle: name)
        }
    }
    
    func loadUserSettings(enableElements: inout Bool) {
        if let gpxPath = UserDefaults.standard.object(forKey: "gpxPathKey") {
            let url = URL(fileURLWithPath: gpxPath as! String)
            if( url.pathExtension == "gpx" ) {
                enableElements = true
                pathLabel.stringValue = gpxPath as! String
            }
        }
    }
    
    func setElements(isEnabled : Bool) {
        if(isEnabled) {
            gpxFile.load(filePath: pathLabel.stringValue, gpsLocation: &gpsLocation)
            showCoordinates()
        }
        
        citySelector.isEnabled = isEnabled
        latitudeText.isEnabled = isEnabled
        longitudeText.isEnabled = isEnabled
        applyButton.isEnabled = isEnabled
        saveButton.isEnabled = isEnabled
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
    
    @IBAction func applyTouched(_ sender: Any) {
        let key = citySelector.titleOfSelectedItem
        let coordinates = cities[key!]
        gpsLocation.setCoordinates(lat: coordinates![0], lon: coordinates![1])
        
        saveCoordinates()
        showCoordinates()
    }
    
    @IBAction func saveTouched(_ sender: Any) {
        saveCoordinates()
    }
    
    @IBAction func findGPXFileTouched(_ sender: Any) {
        let dialog = NSOpenPanel();
        dialog.title                   = "Choose a .gpx file";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseDirectories    = false;
        dialog.canCreateDirectories    = false;
        dialog.allowsMultipleSelection = false;
        dialog.allowedFileTypes        = ["gpx"];
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url
            
            if (result != nil) {
                let path = result!.path
                pathLabel.stringValue = path
                
                UserDefaults.standard.set(path, forKey: "gpxPathKey")
                
                setElements(isEnabled: true)
            }
        } else {
            return
        }
    }
}

