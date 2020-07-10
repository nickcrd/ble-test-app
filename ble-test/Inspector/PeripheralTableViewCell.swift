//
//  PeripheralTableViewCell.swift
//  ble-test
//
//  Created by nc on 10.02.20.
//  Copyright © 2020 NICKCONTROL Studios. All rights reserved.
//

import UIKit

class PeripheralTableViewCell: UITableViewCell {

    @IBOutlet var deviceName: UILabel!;
    @IBOutlet var rssi: UILabel!;
    @IBOutlet var txPower: UILabel!;
    @IBOutlet var dist: UILabel!;

    
    func setBleDevice(bleDevice: BLEDevice)
    {
        deviceName.text = bleDevice.deviceName;
//        rssi.text = String(bleDevice.rssi);
        
        rssi.text = "RSSI: \(bleDevice.rssi)"
        txPower.text = "txPower: \(bleDevice.txPowerLevel ?? -1)"
        dist.text = "\(bleDevice.distanceInMeters)m"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
