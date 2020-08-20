//
//  MoneyboxURLRequestBuilderTests.swift
//  Moneybox-LightTests
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

@testable import Moneybox_Light
import XCTest

class MoneyboxURLRequestBuilderTests: XCTestCase {
    
    func test_moneyBoxURL() {
        
        // the MoneyboxURLRequestBuilder should return a URLRequest with the correct base-headers fields set
        
        guard let mockURL = URL(string: "www.mockURLString.com") else {
            XCTFail("Could not create mockURL")
            return
        }
        let urlRequest = MoneyboxURLRequestBuilder.urlRequest(url: mockURL)
        guard
        let allHeaders = urlRequest.allHTTPHeaderFields,
        let appId = allHeaders["AppId"],
        let contentType = allHeaders["Content-Type"],
        let appVersion = allHeaders["appVersion"],
        let apiVersion = allHeaders["apiVersion"]
            else {
                XCTFail("Base http headers not found")
                return
        }
        
        XCTAssertEqual(appId, "8cb2237d0679ca88db6464")
        XCTAssertEqual(contentType, "application/json")
        XCTAssertEqual(appVersion, "7.10.0")
        XCTAssertEqual(apiVersion, "3.0.0")
        
    }
    
}
