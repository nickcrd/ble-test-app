//
//  ServerDebugViewController.swift
//  ble-test
//
//  Created by nc on 28.07.20.
//  Copyright © 2020 NICKCONTROL Studios. All rights reserved.
//

import UIKit

class ServerDebugViewController: UIViewController {
        
    
    @IBOutlet weak var baseUrlTextField: UITextField!
    
    @IBOutlet weak var clientIdLabel: UILabel!
    @IBOutlet weak var apiKeyLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseUrlTextField.text = TrableApi.shared.baseUrl
        clientIdLabel.text = TrableApi.shared.clientId
        apiKeyLabel.text = TrableApi.shared.apiKey

    }

    @IBAction func enrollClient() {

        TrableApi.shared.enrollClient(completion: { res in
            TrableApi.shared.clientId = res.clientId
            TrableApi.shared.apiKey = res.apiKey
            
            DispatchQueue.main.sync {
                self.clientIdLabel.text = TrableApi.shared.clientId
                self.apiKeyLabel.text = TrableApi.shared.apiKey
            }
        })

    }
    
    @IBAction func updateBaseUrl(_ sender: Any) {
        TrableApi.shared.baseUrl = baseUrlTextField.text!
    }
}

