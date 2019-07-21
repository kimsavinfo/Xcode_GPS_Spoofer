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
    @IBOutlet weak var movingSpeed: NSSegmentedControl!
    
    let gpxPathKey = "gpxPath"
    var gpxFile = GPXFile()
    var gpsLocation = GPSLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
            self.keyDown(with: $0)
            return nil
        }
        loadCities()
        
        var enable = false
        loadUserSettings(enableElements: &enable)
        setElements(isEnabled: enable)
        
        terminal.becomeFirstResponder()
    }

    func loadCities() {
        citySelector.removeAllItems()
        
        for name in citiesKeys {
            citySelector.addItem(withTitle: name)
        }
    }
    
    func loadUserSettings(enableElements: inout Bool) {
        if let gpxPath = UserDefaults.standard.object(forKey: "gpxPathKey") {
            let path = gpxPath as! String
            let url = URL(fileURLWithPath: path)
            
            let fileManager = FileManager.default
            if url.pathExtension == "gpx" && fileManager.fileExists(atPath: path) {
                enableElements = true
                pathLabel.stringValue = gpxPath as! String
            }
        }
    }
    
    func setElements(isEnabled : Bool) {
        if(isEnabled) {
            gpxFile.load(filePath: pathLabel.stringValue, gpsLocation: &gpsLocation)
            showCoordinates()
            terminal.documentView!.insertText("Press arrow keys to move :)\n")
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
        showCoordinates()
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
    
    // MARK: - Keyboard actions
    
    
    override func keyDown(with event: NSEvent) {
        let speed:Double = Double(movingSpeed.selectedSegment + 1)
        
        if (event.keyCode == 123){
            terminal.documentView!.insertText("Going west\n")
            gpsLocation.moveLongitude(left: false, speed: speed);
            
            saveCoordinates()
        }
        if (event.keyCode == 124){
            terminal.documentView!.insertText("Going east\n")
            gpsLocation.moveLongitude(left: true, speed: speed);
            
            saveCoordinates()
        }
        if (event.keyCode == 126){
            terminal.documentView!.insertText("Going north\n")
            gpsLocation.moveLatitude(up: true, speed: speed)
            
            saveCoordinates()
        }
        if (event.keyCode == 125){
            terminal.documentView!.insertText("Going south\n")
            gpsLocation.moveLatitude(up: false, speed: speed)
            
            saveCoordinates()
        }
    }
}

