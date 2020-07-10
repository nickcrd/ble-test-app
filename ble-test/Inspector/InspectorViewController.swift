//
//  InspectorViewController.swift
//  ble-test
//
//  Created by nc on 10.02.20.
//  Copyright © 2020 NICKCONTROL Studios. All rights reserved.
//

import UIKit
import CoreBluetooth

class InspectorViewController: UITableViewController, CBCentralManagerDelegate, UITextFieldDelegate
{
  
    let bleManager: CBCentralManager = CBCentralManager.init();
    
    @IBOutlet var statusLabel: UILabel!;
    @IBOutlet var nameBox: UITextField!;
        
    var filterName: String?;
    
    var data: [BLEDevice] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bleManager.delegate = self;
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            if (self.bleManager.isScanning) {
                self.statusLabel.backgroundColor = UIColor.green;
                self.statusLabel.text = "CURRENTLY LISTENING FOR PACKETS";
            } else {
                self.statusLabel.backgroundColor = UIColor.systemTeal;
                self.statusLabel.text = "READY";
            }
        }
    }
    

    @IBAction func updateName() {
        filterName = nameBox.text!;
        stopScanning();
    }
       
    @IBAction func startScanning() {
       
        bleManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true]);

       self.statusLabel.backgroundColor = UIColor.orange;
       self.statusLabel.text = "STARTING SCAN...";
               
    }
   
    @IBAction func stopScanning() {
        bleManager.stopScan()
        self.statusLabel.backgroundColor = UIColor.red;
        self.statusLabel.text = "STOPPING SCAN...";
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
        
        var txPowerLevel = advertisementData[CBAdvertisementDataTxPowerLevelKey] as? Double
        
        if (txPowerLevel == nil) {
            print("tx Power is not present in advertisement data")
        }
        
       // Apply name filter
        if (filterName != nil && filterName!.lowercased() != peripheralName.lowercased()) {
            return;
        }
        
        data.append(BLEDevice(deviceName: peripheralName, txPowerLevel: txPowerLevel, rssi: RSSI.doubleValue))
        tableView.reloadData()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
          return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }

      
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "peripheralCell", for: indexPath) as! PeripheralTableViewCell;
        
        cell.setBleDevice(bleDevice: data[data.count-indexPath.row-1])

        return cell
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
