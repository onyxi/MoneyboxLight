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

/// DataAccessObject is the interface for an object which provides access to application data - either from local sttorage or from networked sources
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
    
    /// Provides a wrapper function for getAccounts - to remove requirement to include bearerToken in the call
    func getAccounts(completion: @escaping (AccountsResult) -> ()) {
        getAccounts(bearerToken: nil, completion: completion)
    }
    
    /// Provides a wrapper function for makeOneOffPayment - to remove requirement to include bearerToken in the call
    func makeOneOffPayment(account: Account, amount: Int, completion: @escaping (PaymentResult) -> ()) {
        makeOneOffPayment(bearerToken: nil, account: account, amount: amount, completion: completion)
    }
}

// MARK: DataAccessObjectImpl

class DataAccessObjectImpl: DataAccessObject {
    
    let keyValueStore: KeyValueStoreProtocol
    let secureKeyValueStore: SecureKeyValueStoreProtocol
    let operationQueue: OperationQueue
    
    /**
    - Parameter keyValueStore: an object that provides access to local unencryped key-value storage
    - Parameter secureKeyValueStore: an object that provides access to local encryped key-value storage
    - Parameter operationQueue: a queue for Operations to be added to
    */
    init(keyValueStore: KeyValueStoreProtocol = UserDefaults.standard, secureKeyValueStore: SecureKeyValueStoreProtocol = KeychainSwift(), operationQueue: OperationQueue = OperationQueue()) {
        self.keyValueStore = keyValueStore
        self.secureKeyValueStore = secureKeyValueStore
        self.operationQueue = operationQueue
    }
}
    
// MARK: Local storage...

extension DataAccessObjectImpl {
    
    /**
     Stores the given session data in encrypted storage, using UserDefaults to store the reference key.
    - Parameter session: The Session to be saved
    */
    func saveSession(session: Session) {
        let secureStorageKey = UUID().uuidString
        keyValueStore.set(secureStorageKey, forKey: StorageKey.bearerToken)
        _ = secureKeyValueStore.set(session.bearerToken, forKey: secureStorageKey, withAccess: .accessibleWhenUnlockedThisDeviceOnly)
    }
    
    /**
     Fetches the session data from encrypted storage by first getting the reference key for it from UserDefaults.
    - Returns: an optional Session object, if token found in storage
    */
    func getSession() -> Session? {
        guard
            let secureStorageKey: String = keyValueStore.string(forKey: StorageKey.bearerToken),
            let bearerToken = secureKeyValueStore.get(secureStorageKey)
        else { return nil }
        return Session(bearerToken: bearerToken)
    }
    
    /**
     Stores User details in local unencrypted storage.
    - Parameter user: The User to be saved
    */
    func saveUser(user: User) {
        keyValueStore.set(user.name, forKey: StorageKey.userName)
    }
    
    /**
     Fetches user data from local unencrypted storage
    - Returns: an optional User object, if details found in storage
    */
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
    
    /**
     Attempts login with the server given a target account username and password
    - Parameter username: The target account username
    - Parameter password: The target account password
    - Parameter completion: The function to be exectued on completion of the task
    */
    func login(username: String, password: String, completion: @escaping (LoginResult) -> ()) {
        guard let loginOperation = LoginOperation(username: username, password: password, completion: completion) else { return }
        operationQueue.addOperation(loginOperation)
    }
    
    /**
     Attempts to fetche the user's account details from the server
     - Parameter bearerToken: The auth token of the target account
     - Parameter completion: The function to be exectued on completion of the task
    */
    func getAccounts(bearerToken: String?, completion: @escaping (AccountsResult) -> ()) {
        guard let bearerToken = bearerToken ?? self.getSession()?.bearerToken else {
            completion(.failure(.unauthorized))
            return
        }
        guard let getAccountsOperation = GetAccountsOperation(bearerToken: bearerToken, completion: completion) else { return }
        operationQueue.addOperation(getAccountsOperation)
    }
    
    /**
     Attempts to fetch the user's account details from the server
     - Parameter bearerToken: The auth token of the target account
     - Parameter completion: The function to be exectued on completion of the task
    */
    func makeOneOffPayment(bearerToken: String?, account: Account, amount: Int, completion: @escaping (PaymentResult) -> ()) {
        guard let bearerToken = bearerToken ?? self.getSession()?.bearerToken else {
            completion(.failure(.unauthorized))
            return
        }
        guard let makeOneOffPaymentOperation = MakeOneOffPaymentOperation(account: account, amount: amount, bearerToken: bearerToken, completion: completion) else { return }
        operationQueue.addOperation(makeOneOffPaymentOperation)
    }
}
