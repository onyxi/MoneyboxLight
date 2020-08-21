//
//  Int+Additions.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation

extension Int {
    
    /**
     Returns an optional DataServiceError associated with http error codes for this Int
    */
    func asHttpError() -> DataServiceError? {
        if (200 ... 299) ~= self {
            return nil
        } else {
            switch self {
            case 401:
                return .unauthorized
            case 500:
                return .serverError
            default:
                return .applicationError
            }
        }
    }
    
}
