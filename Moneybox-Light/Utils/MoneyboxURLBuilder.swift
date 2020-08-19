//
//  MoneyboxURLBuilder.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 19/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation

class MoneyboxURLRequestBuilder {
    static func urlRequest(url: URL) -> URLRequest {
         var request = URLRequest(url: url)
        request.setValue(Environment.appId, forHTTPHeaderField: "AppId")
        request.setValue(Environment.contentType, forHTTPHeaderField: "Content-Type")
        request.setValue(Environment.appVersion, forHTTPHeaderField: "appVersion")
        request.setValue(Environment.apiVersion, forHTTPHeaderField: "apiVersion")
        return request
    }
}