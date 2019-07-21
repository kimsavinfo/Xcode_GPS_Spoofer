# Xcode_GPS_Spoofer

1. Launch GPS_Spoofer_MacOS
    1.1 Find gpx file > path to gps_location.gpx
    1.2 Choose the city wanted > Apply
    
    
2. Launch GPS_Spoofer_iOS
    2.1 Before launching, check that "Scheme" > "Options" > "Allow Location Simulation" is checked and that "Default Location" is linked to gps_location
    
    
3. Open the wanted application


4. Launch autoclick_update_gps.scpt (Scipt Editor to launch AppleScript)
    4.1 If an error message is shown, click on XCode with GPS_Spoofer_iOS and open the menu bar with "Debug" > "Simulate Location" > "gps_location", then try again to launch the script
