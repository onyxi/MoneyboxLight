//
//  Product.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation

struct Product: Codable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "FriendlyName"
    }
}
