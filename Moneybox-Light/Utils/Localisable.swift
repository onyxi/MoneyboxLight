//
//  Localisable.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 19/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation

public func localisableString(forKey key: String) -> String {
    return NSLocalizedString(key, tableName: "Localisable", bundle: Bundle.main, comment: "")
}
