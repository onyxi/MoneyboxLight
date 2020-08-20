//
//  KeyValueStore.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation

protocol KeyValueStoreProtocol {
    func set(_ value: Any?, forKey: String)
    func string(forKey defaultName: String) -> String?
}

// MARK: Extend UserDefaults to adopt KeyValueStoreProtocol

extension UserDefaults: KeyValueStoreProtocol {
    func string(forKey defaultName: String) -> Any? {
        return object(forKey: defaultName)
    }
}
