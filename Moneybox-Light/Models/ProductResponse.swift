//
//  ProductResponse.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation

struct ProductResponse: Codable {
    let investorProductId: Int
    let planValue: Double
    let moneybox: Double
    let product: Product
    
    enum CodingKeys: String, CodingKey {
        case investorProductId = "Id"
        case planValue = "PlanValue"
        case moneybox = "Moneybox"
        case product = "Product"
    }
}
