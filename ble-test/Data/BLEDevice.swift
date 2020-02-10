//
//  BLEDevice.swift
//  ble-test
//
//  Created by nc on 10.02.20.
//  Copyright © 2020 NICKCONTROL Studios. All rights reserved.
//

import Foundation

struct BLEDevice {
    var deviceName: String;
    var rssi: Int;
    
    init(deviceName: String, rssi: Int)
    {
        self.deviceName = deviceName;
        self.rssi = rssi;
    }
}
