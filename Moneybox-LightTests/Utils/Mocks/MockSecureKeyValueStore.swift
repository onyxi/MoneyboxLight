//
//  MockSecureKeyValueStore.swift
//  Moneybox-LightTests
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

@testable import Moneybox_Light
import KeychainSwift

class MockSecureKeyValueStore: SecureKeyValueStoreProtocol {
    
    var get_calls = 0
    var get_key: String?
    var get_stringToReturn: String?
    func get(_ key: String) -> String? {
        get_calls += 1
        get_key = key
        return get_stringToReturn
    }
    
    var set_calls = 0
    var set_value: String?
    var set_forKey: String?
    var set_withAccess: KeychainSwiftAccessOptions?
    var set_boolToReturn = true
    func set(_ value: String, forKey key: String, withAccess access: KeychainSwiftAccessOptions?) -> Bool {
        set_calls += 1
        set_value = value
        set_forKey = key
        set_withAccess = access
        return set_boolToReturn
    }
    
}
