//
//  BLEDevice.swift
//  ble-test
//
//  Created by nc on 10.02.20.
//  Copyright © 2020 NICKCONTROL Studios. All rights reserved.
//

import Foundation

struct BLEDevice {
    var deviceName: String
    var txPowerLevel: Double?
    var rssi: Double
    
    init(deviceName: String, txPowerLevel: Double?, rssi: Double)
    {
        self.deviceName = deviceName;
        self.txPowerLevel = txPowerLevel;
        self.rssi = rssi;
    }
    
    public var distanceInMeters: Double {
        // Apparently, iOS sends at 12 bm per default (?) so let's use that as a default value
        let power = txPowerLevel ?? 12.0
        
        let distance = pow(10, (power - rssi) / 20)
        return distance / 1000
    }
}
