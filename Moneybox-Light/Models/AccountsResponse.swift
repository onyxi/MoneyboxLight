//
//  AccountsResponse.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation

struct AccountsResponse: Codable {
    let totalPlanValue: Double
    let productResponses: [ProductResponse]
    
    enum CodingKeys: String, CodingKey {
        case totalPlanValue = "TotalPlanValue"
        case productResponses = "ProductResponses"
    }
}
