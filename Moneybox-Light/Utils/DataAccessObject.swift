//
//  DataAccessObject.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 18/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation
import KeychainSwift

enum DataServiceError: Error { case applicationError, serverError, unauthorized, networkError, jsonError }

typealias LoginResult = Result<LoginResponse, DataServiceError>
typealias AccountsResult = Result<AccountsResponse, DataServiceError>
typealias PaymentResult = Result<PaymentResponse, DataServiceError>

protocol DataAccessObject {
    func login(username: String, password: String, completion: @escaping (LoginResult) -> ())
    func saveSession(session: Session)
    func getSession() -> Session?
    func saveUser(user: User)
    func getUser() -> User?
    func getAccounts(bearerToken: String?, completion: @escaping (AccountsResult) -> ())
    func makeOneOffPayment(bearerToken: String?, account: Account, amount: Int, completion: @escaping (PaymentResult) -> ())
}

extension DataAccessObject {
    func getAccounts(completion: @escaping (AccountsResult) -> ()) {
        getAccounts(bearerToken: nil, completion: completion)
    }
    
    func makeOneOffPayment(account: Account, amount: Int, completion: @escaping (PaymentResult) -> ()) {
        makeOneOffPayment(bearerToken: nil, account: account, amount: amount, completion: completion)
    }
}

// MARK: DataAccessObjectImpl

class DataAccessObjectImpl: DataAccessObject {
    
    let keyValueStore: KeyValueStoreProtocol
    let secureKeyValueStore: SecureKeyValueStoreProtocol
    let operationQueue: OperationQueue
    
    init(keyValueStore: KeyValueStoreProtocol = UserDefaults.standard, secureKeyValueStore: SecureKeyValueStoreProtocol = KeychainSwift(), operationQueue: OperationQueue = OperationQueue()) {
        self.keyValueStore = keyValueStore
        self.secureKeyValueStore = secureKeyValueStore
        self.operationQueue = operationQueue
    }
}
    
// MARK: Local storage...

extension DataAccessObjectImpl {
    
    /// Stores the given session data in encrypted storage, using UserDefaults to store the reference key.
    func saveSession(session: Session) {
        let secureStorageKey = UUID().uuidString
        keyValueStore.set(secureStorageKey, forKey: StorageKey.bearerToken)
        _ = secureKeyValueStore.set(session.bearerToken, forKey: secureStorageKey, withAccess: .accessibleWhenUnlockedThisDeviceOnly)
    }
    
    /// Fetches the session data from encrypted storage by first getting the reference key for it from UserDefaults.
    func getSession() -> Session? {
        guard
            let secureStorageKey: String = keyValueStore.string(forKey: StorageKey.bearerToken),
            let bearerToken = secureKeyValueStore.get(secureStorageKey)
        else { return nil }
        return Session(bearerToken: bearerToken)
    }
    
    func saveUser(user: User) {
        keyValueStore.set(user.name, forKey: StorageKey.userName)
    }
    
    func getUser() -> User? {
        if let name = keyValueStore.string(forKey: StorageKey.userName) {
            return User(name: name)
        } else {
            return nil
        }
    }
}

// MARK: Network data...

extension DataAccessObjectImpl {
    
    func login(username: String, password: String, completion: @escaping (LoginResult) -> ()) {
        guard let loginOperation = LoginOperation(username: username, password: password, completion: completion) else { return }
        operationQueue.addOperation(loginOperation)
    }
    
    func getAccounts(bearerToken: String?, completion: @escaping (AccountsResult) -> ()) {
        guard let bearerToken = bearerToken ?? self.getSession()?.bearerToken else {
            completion(.failure(.unauthorized))
            return
        }
        guard let getAccountsOperation = GetAccountsOperation(bearerToken: bearerToken, completion: completion) else { return }
        operationQueue.addOperation(getAccountsOperation)
    }
    
    func makeOneOffPayment(bearerToken: String?, account: Account, amount: Int, completion: @escaping (PaymentResult) -> ()) {
        guard let bearerToken = bearerToken ?? self.getSession()?.bearerToken else {
            completion(.failure(.unauthorized))
            return
        }
        guard let makeOneOffPaymentOperation = MakeOneOffPaymentOperation(account: account, amount: amount, bearerToken: bearerToken, completion: completion) else { return }
        operationQueue.addOperation(makeOneOffPaymentOperation)
    }
}
