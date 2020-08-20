//
//  MockDAO.swift
//  Moneybox-LightTests
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

@testable import Moneybox_Light

class MockDAO: DataAccessObject {
    
    var login_calls = 0
    var login_username: String?
    var login_password: String?
    var login_completion: ((LoginResult) -> ())?
    func login(username: String, password: String, completion: @escaping (LoginResult) -> ()) {
        login_calls += 1
        login_username = username
        login_password = password
        login_completion = completion
    }
    
    var saveSession_calls = 0
    var saveSession_session: Session?
    func saveSession(session: Session) {
        saveSession_calls += 1
        saveSession_session = session
    }
    
    var getSession_calls = 0
    var getSession_sessionToReturn: Session?
    func getSession() -> Session? {
        getSession_calls += 1
        return getSession_sessionToReturn
    }
    
    var saveUser_calls = 0
    var saveUser_user: User?
    func saveUser(user: User) {
        saveUser_calls += 1
        saveUser_user = user
    }
    
    var getUser_calls = 0
    var getUser_userToReturn: User?
    func getUser() -> User? {
        getUser_calls += 1
        return getUser_userToReturn
    }
    
    var getAccounts_calls = 0
    var getAccounts_bearerToken: String?
    var getAccounts_completion: ((AccountsResult) -> ())?
    func getAccounts(bearerToken: String?, completion: @escaping (AccountsResult) -> ()) {
        getAccounts_calls += 1
        getAccounts_bearerToken = bearerToken
        getAccounts_completion = completion
    }
    
    var makeOneOffPayment_calls = 0
    var makeOneOffPayment_bearerToken: String?
    var makeOneOffPayment_account: Account?
    var makeOneOffPayment_amount: Int?
    var makeOneOffPayment_completion: ((PaymentResult) -> ())?
    func makeOneOffPayment(bearerToken: String?, account: Account, amount: Int, completion: @escaping (PaymentResult) -> ()) {
        makeOneOffPayment_calls += 1
        makeOneOffPayment_bearerToken = bearerToken
        makeOneOffPayment_account = account
        makeOneOffPayment_amount = amount
        makeOneOffPayment_completion = completion
    }
    
}
