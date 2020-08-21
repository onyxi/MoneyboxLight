//
//  MoneyboxURLBuilder.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 19/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation

/// MoneyboxURLRequestBuilder enables simple construction of URLRequest objects with base header fields added
class MoneyboxURLRequestBuilder {
    
    /**
      Creates a URLRequest with base headers added
     - Parameter url: a URL object to add base header fields to
     - Returns: a URLRequest with base header fields added
     */
    static func urlRequest(url: URL) -> URLRequest {
         var request = URLRequest(url: url)
        request.setValue(Environment.appId, forHTTPHeaderField: HttpHeader.appId)
        request.setValue(Environment.contentType, forHTTPHeaderField: HttpHeader.contentType)
        request.setValue(Environment.appVersion, forHTTPHeaderField: HttpHeader.appVersion)
        request.setValue(Environment.apiVersion, forHTTPHeaderField: HttpHeader.apiVersion)
        return request
    }
}
