//
//  UserAuthorization.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 19/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {
    let user: User
    let session: Session
    
    enum CodingKeys: String, CodingKey {
        case user = "User"
        case session = "Session"
    }
}
