//
//  MockKeyValueStore.swift
//  Moneybox-LightTests
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

@testable import Moneybox_Light

class MockKeyValueStore: KeyValueStoreProtocol {
    
    var set_calls = 0
    var set_value: Any?
    var set_forKey: String?
    func set(_ value: Any?, forKey: String) {
        set_calls += 1
        set_value = value
        set_forKey = forKey
    }
    
    var string_calls = 0
    var string_forKey: String?
    var string_toReturn: String?
    func string(forKey defaultName: String) -> String? {
        string_calls += 1
        string_forKey = defaultName
        return string_toReturn
    }
    
}
