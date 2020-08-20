//
//  DataAccessObjectTests.swift
//  Moneybox-LightTests
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

@testable import Moneybox_Light
import XCTest

class DataAccessObjectTests: XCTestCase {
    
    var mockKeyValueStore: MockKeyValueStore!
    var mockSecureKeyValueStore: MockSecureKeyValueStore!
    var mockOperationQueue: MockOperationQueue!
    var dao: DataAccessObjectImpl!
    
    override func setUp() {
        mockKeyValueStore = MockKeyValueStore()
        mockSecureKeyValueStore = MockSecureKeyValueStore()
        mockOperationQueue = MockOperationQueue()
        dao = DataAccessObjectImpl(keyValueStore: mockKeyValueStore, secureKeyValueStore: mockSecureKeyValueStore, operationQueue: mockOperationQueue)
    }
    
    func test_login() {
        // when login is called a LoginOperation should be added to the OpeerationQueue
        let mockUsername = "mockUsername"
        let mockPassword = "mockPassword"
        dao.login(username: mockUsername, password: mockPassword) { _ in }
        XCTAssertEqual(mockOperationQueue.capturedOperations.count, 1)
        XCTAssertTrue(mockOperationQueue.lastCapturedOperation is LoginOperation)
    }
    
    func test_saveSession() {
        // when saveSession is called, a unique ID should be stored in regular storage under the 'bearer token' storage key, and the bearer token itself should be stored in secure storage using the unique ID captured in regular storage as its reference key.
        let mockBearerToken = "mockBearerToken"
        let mockSession = Session(bearerToken: mockBearerToken)
        dao.saveSession(session: mockSession)
        XCTAssertEqual(mockKeyValueStore.set_calls, 1)
        XCTAssertNotNil(mockKeyValueStore.set_value)
        XCTAssertEqual(mockKeyValueStore.set_forKey, StorageKey.bearerToken)
        XCTAssertEqual(mockSecureKeyValueStore.set_calls, 1)
        XCTAssertEqual(mockSecureKeyValueStore.set_value, mockBearerToken)
        XCTAssertNotNil(mockSecureKeyValueStore.set_forKey)
    }
    
    func test_getSession() {
        // when getSession is called, the secure-storage reference should be retrieved from regular storage using the 'bearer token' storage key, and the bearer token itself should be retrieved from secure storage using the reference key fetched from regular storage.
        let mockBearerToken = "mockBearerToken"
        let mockSecureStorageReference = "mockSecureStorageReference"
        mockKeyValueStore.string_toReturn = mockSecureStorageReference
        mockSecureKeyValueStore.get_stringToReturn = mockBearerToken
        let returnedSession = dao.getSession()
        XCTAssertEqual(mockKeyValueStore.string_calls, 1)
        XCTAssertEqual(mockKeyValueStore.string_forKey, StorageKey.bearerToken)
        XCTAssertEqual(mockSecureKeyValueStore.get_calls, 1)
        XCTAssertEqual(mockSecureKeyValueStore.get_key, mockSecureStorageReference)
        XCTAssertEqual(returnedSession?.bearerToken, mockBearerToken)
    }
    
    func test_saveUser() {
        // when saveUser is called the user's name should be set in regular storage using the 'user name' storage key
        let mockName = "mockName"
        let mockUser = User(name: mockName)
        dao.saveUser(user: mockUser)
        XCTAssertEqual(mockKeyValueStore.set_calls, 1)
        XCTAssertEqual(mockKeyValueStore.set_value as? String, mockName)
        XCTAssertEqual(mockKeyValueStore.set_forKey, StorageKey.userName)
    }
    
    func test_getUser() {
        // when getUser is called the user's name should be fetched from regular storage using the 'user name' storage key, and a User object should be created with it and returned to the caller.
        let mockName = "mockName"
        mockKeyValueStore.string_toReturn = mockName
        let returnedUser = dao.getUser()
        XCTAssertEqual(mockKeyValueStore.string_calls, 1)
        XCTAssertEqual(mockKeyValueStore.string_forKey, StorageKey.userName)
        XCTAssertEqual(returnedUser?.name, mockName)
    }
    
    func test_getAccounts() {
        // when getAccounts is called a GetAccountsOperation should be added to the OpeerationQueue
        dao.getAccounts(bearerToken: "mockBeaerToken") { _ in }
        XCTAssertEqual(mockOperationQueue.capturedOperations.count, 1)
        XCTAssertTrue(mockOperationQueue.lastCapturedOperation is GetAccountsOperation)
    }
    
    func test_makeOneOffPayment() {
        // when makeOneOffPayment is called a MakeOneOffPaymentOperation should be added to the OpeerationQueue
        let mockAccount = Account(productId: 1, name: "Mock Account", value: 1000.0, moneybox: 20.0)
        let mockAmount = 50
        dao.makeOneOffPayment(bearerToken: "mockBeaerToken", account: mockAccount, amount: mockAmount) { _ in }
        XCTAssertEqual(mockOperationQueue.capturedOperations.count, 1)
        XCTAssertTrue(mockOperationQueue.lastCapturedOperation is MakeOneOffPaymentOperation)
    }
    
}
