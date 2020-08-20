//
//  SecureKeyValueStore.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation
import KeychainSwift

protocol SecureKeyValueStoreProtocol {
    func get(_ key: String) -> String?
    func set(_ value: String, forKey key: String, withAccess access: KeychainSwiftAccessOptions?) -> Bool
}

// MARK: Extend KeychainSwift to adopt SecureKeyValueStoreProtocol
extension KeychainSwift: SecureKeyValueStoreProtocol {}
