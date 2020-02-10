//
//  BLETestViewController.swift
//  ble-test
//
//  Created by nc on 07.02.20.
//  Copyright © 2020 NICKCONTROL Studios. All rights reserved.
//

import UIKit
import CoreBluetooth

class BLETestViewController: UIViewController, CBPeripheralManagerDelegate, UITextFieldDelegate {

    let bleManager: CBPeripheralManager = CBPeripheralManager.init()
    @IBOutlet var statusLabel: UILabel!;
    @IBOutlet var nameBox: UITextField!;
    
    var advertisementName = "test-ble app";

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bleManager.delegate = self;
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            if (self.bleManager.isAdvertising) {
                self.statusLabel.backgroundColor = UIColor.green;
                self.statusLabel.text = "CURRENTLY ADVERTISING";
            } else {
                self.statusLabel.backgroundColor = UIColor.systemTeal;
                self.statusLabel.text = "READY";
            }
        }
    }

    @IBAction func updateName() {
        advertisementName = nameBox.text!;
        stopAdvertising();
    }
    
    @IBAction func startAdvertising() {
        
        bleManager.startAdvertising([
            CBAdvertisementDataLocalNameKey: advertisementName
        ])
        
        self.statusLabel.backgroundColor = UIColor.orange;
        self.statusLabel.text = "STARTING...";
                
    }
    
    @IBAction func stopAdvertising() {
        bleManager.stopAdvertising()
        self.statusLabel.backgroundColor = UIColor.red;
        self.statusLabel.text = "STOPPING...";
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewDidDisappear(_ animated: Bool) {
        bleManager.stopAdvertising()
    }
    
    
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        print("Updated state: \(peripheral.state)");
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
