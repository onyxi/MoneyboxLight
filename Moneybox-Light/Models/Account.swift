//
//  Account.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 19/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation

struct Account: Equatable {
    let productId: Int
    let name: String
    let value: Double
    let moneybox: Double
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.productId == rhs.productId
    }
    
}
