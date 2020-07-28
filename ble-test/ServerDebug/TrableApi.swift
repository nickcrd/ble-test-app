//
//  TrableApi.swift
//  ble-test
//
//  Created by nc on 28.07.20.
//  Copyright © 2020 NICKCONTROL Studios. All rights reserved.
//

import Foundation

class TrableApi {
    static var shared: TrableApi = TrableApi();
    
    @UserDefault(key: "trable_baseUrl", defaultValue: "http://localhost/api")
    var baseUrl: String
    
    @UserDefault(key: "trable_clientId", defaultValue: "123456")
    var clientId: String
    @UserDefault(key: "trable_apiKey", defaultValue: "xxx")
    var apiKey: String
    
    func enrollClient(completion: @escaping (ClientEnrollmentResponse) -> Void) {
        let url = URL(string: baseUrl + "/v1/devices/enrollClient")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let jsonDecoder = JSONDecoder()
                let data = try jsonDecoder.decode(ClientEnrollmentResponse.self, from: data!)
                completion(data)
            } catch {
               print("ERROR in enrollClient: \(error)")
            }
        }
        task.resume()
    }
}
