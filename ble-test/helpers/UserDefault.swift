//
//  UserDefault.swift
//  ble-test
//
//  Created by nc on 10.07.20.
//  Copyright © 2020 NICKCONTROL Studios. All rights reserved.
//

import Foundation

@propertyWrapper
public struct UserDefault<T: Any> {
    public let key: String
    public let defaultValue: T
    
    init(key: String, defaultValue: T)
    {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
}

