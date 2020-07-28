//
//  ClientEnrollmentResponse.swift
//  ble-test
//
//  Created by nc on 28.07.20.
//  Copyright © 2020 NICKCONTROL Studios. All rights reserved.
//

import Foundation

struct ClientEnrollmentResponse: Codable {
    let clientId: String
    let apiKey: String
}
