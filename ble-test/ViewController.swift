//
//  ViewController.swift
//  ble-test
//
//  Created by nc on 07.02.20.
//  Copyright © 2020 NICKCONTROL Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var badgeView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let versionString = "v\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String)--\(Bundle.main.infoDictionary?["CFBundleVersion"] as! String)"
        badgeView.downloaded(from: "https://raster.shields.io/badge/trable--debug-\(versionString)-blue.png", contentMode: badgeView.contentMode)
    }

}

