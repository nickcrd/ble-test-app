//
//  MeasureViewController.swift
//  ble-test
//
//  Created by nc on 10.07.20.
//  Copyright © 2020 NICKCONTROL Studios. All rights reserved.
//

import UIKit
import CoreBluetooth

class MeasureViewController: UIViewController, CBCentralManagerDelegate, UITextFieldDelegate
{
    let bleManager: CBCentralManager = CBCentralManager.init();
            
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var rssiLabel: UILabel!
    
    @IBOutlet weak var txPowerLabel: UILabel!
    @IBOutlet weak var txPowerSlider: UISlider!
    
    @IBOutlet weak var deviceFilterLabel: UITextField!
    
    var data: BLEDevice?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bleManager.delegate = self;

    }
    
    @IBAction func updatedTxPower(_ sender: UISlider)
    {
        // Update label
        txPowerLabel.text = "\(String(format: "%.2f", sender.value)) dBm"
        
        
        if (data != nil) {
            data?.txPowerLevel = Double(sender.value)
            updateCalc()
        }
    }
    
    func updateCalc() {
        rssiLabel.text = String(format: "%.2f", data!.rssi)
        resultLabel.text = "\(String(format: "%.2f", data!.distanceInMeters))m"
    }

    @IBAction func startScanning() {
        bleManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true]);
    }
    
    @IBAction func stopScanning() {
        bleManager.stopScan()
    }
   
    override func viewDidDisappear(_ animated: Bool) {
        bleManager.stopScan()
    }
   
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print(central.state);
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber)
    {
        // Handle discovered peripherals

        guard var peripheralName = peripheral.name else {
            print("No name defined")
            return;
        }
        
        let advertisedName = advertisementData[CBAdvertisementDataLocalNameKey] as? String
        if (advertisedName != nil)
        {
                peripheralName = advertisedName!
        }
        
       // Apply name filter
        if (deviceFilterLabel.text!.lowercased() != peripheralName.lowercased()) {
            return;
        }
 
        if (data == nil) {
            data = BLEDevice(deviceName: peripheralName, txPowerLevel: Double(txPowerSlider.value), rssi: RSSI.doubleValue)
        } else {
            data!.rssi = RSSI.doubleValue
        }
        
        updateCalc()
       
    }

    
      /*
      // MARK: - Navigation

      // In a storyboard-based application, you will often want to do a little preparation before navigation
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          // Get the new view controller using segue.destination.
          // Pass the selected object to the new view controller.
      }
      */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder()
          return true;
      }

}

    
