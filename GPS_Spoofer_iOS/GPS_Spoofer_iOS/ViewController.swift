//
//  ViewController.swift
//  GPS_Spoofer_iOS
//
//  Created by Kim SAVAROCHE on 18/07/2019.
//  Copyright © 2019 Kim SAVAROCHE. All rights reserved.
//

import UIKit

let appURL = URL(string: "comgooglemaps://");

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        openApplication()
    }
    
    func openApplication() {
        if( UIApplication.shared.canOpenURL(appURL!) ) {
            UIApplication.shared.open(appURL!, options:[:], completionHandler: nil)
        } else {
            print("ERROR - Can't open ", appURL!.absoluteString)
        }
    }

}

