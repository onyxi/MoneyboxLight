//
//  PaymentResponse.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation

struct PaymentResponse: Codable {
    let moneybox: Double
    
    enum CodingKeys: String, CodingKey {
        case moneybox = "Moneybox"
    }
}
