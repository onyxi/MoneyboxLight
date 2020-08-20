//
//  Session.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation

struct Session: Codable, Equatable {
    let bearerToken: String
    
    enum CodingKeys: String, CodingKey {
        case bearerToken = "BearerToken"
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.bearerToken == rhs.bearerToken
    }
}
