//
//  Int+AdditionsTests.swift
//  Moneybox-LightTests
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

@testable import Moneybox_Light
import XCTest

class IntAdditionsTests: XCTestCase {
    
    func test_200_OK() {
        let statusCode = 200
        XCTAssertNil(statusCode.asHttpError())
    }
    
    func test_401_Unauthorized() {
        let statusCode = 401
        XCTAssertEqual(statusCode.asHttpError(), .unauthorized)
    }
    
    func test_500_ServerError() {
        let statusCode = 500
        XCTAssertEqual(statusCode.asHttpError(), .serverError)
    }
    
}
