//
//  DataAccessObject.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 18/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation

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
    func getAccounts(completion: @escaping (AccountsResult) -> ())
    func makeOneOffPayment(account: Account, amount: Int, completion: @escaping (PaymentResult) -> ())
}

// MARK: DataAccessObjectImpl

class DataAccessObjectImpl: DataAccessObject {
    
    static let shared = DataAccessObjectImpl()
    private init() {}
    
    let operationQueue = OperationQueue()
    
    
    // MARK: Local storage...
    
    let defaults = UserDefaults.standard
    
    let bearerTokenKey = "BEARER_TOKEN"
    let userNameKey = "USER_NAME"
    
    func saveSession(session: Session) {
        defaults.set(session.bearerToken, forKey: bearerTokenKey)
    }
    
    func getSession() -> Session? {
        if let bearerToken = defaults.string(forKey: bearerTokenKey) {
            return Session(bearerToken: bearerToken)
        } else {
            return nil
        }
    }
    
    func saveUser(user: User) {
        defaults.set(user.name, forKey: userNameKey)
    }
    
    func getUser() -> User? {
        if let name = defaults.string(forKey: userNameKey) {
            return User(name: name)
        } else {
            return nil
        }
    }
    
    // MARK: Network data...
    
    func login(username: String, password: String, completion: @escaping (LoginResult) -> ()) {
        operationQueue.addOperation { [weak self] in
            guard let url = URL(string: Environment.baseURL + "/users/login") else { return }
            var request = MoneyboxURLRequestBuilder.urlRequest(url: url)
            request.httpMethod = "POST"
            let parameters: [String: Any] = ["Email": username, "Password": password]
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                    completion(.failure(.networkError))
                    return
                }
                self?.loginCompleted(data: data, response: response, completion: completion)
            }
            task.resume()
        }
    }
    
    func loginCompleted(data: Data, response: HTTPURLResponse, completion: @escaping (LoginResult) -> ()) {
        DispatchQueue.main.async {
            if let httpError = self.httpError(from: response) {
                completion(.failure(httpError))
            } else {
                let decoder = JSONDecoder()
                do {
                    let decodedResponse = try decoder.decode(LoginResponse.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    print("Failed to decode JSON")
                    completion(.failure(.applicationError))
                }
            }
        }
    }
    
    func getAccounts(completion: @escaping (AccountsResult) -> ()) {
        operationQueue.addOperation { [weak self] in
            guard let url = URL(string: Environment.baseURL + "/investorproducts") else { return }
            var request = MoneyboxURLRequestBuilder.urlRequest(url: url)
            if let token = self?.getSession()?.bearerToken {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                    completion(.failure(.networkError))
                    return
                }
                self?.getAccountsCompleted(data: data, response: response, completion: completion)
            }
            task.resume()
        }
    }
    
    func getAccountsCompleted(data: Data, response: HTTPURLResponse, completion: @escaping (AccountsResult) -> ()) {
        DispatchQueue.main.async {
            if let httpError = self.httpError(from: response) {
                completion(.failure(httpError))
            } else {
                let decoder = JSONDecoder()
                do {
                    let decodedResponse = try decoder.decode(AccountsResponse.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(.jsonError))
                }
            }
        }
    }
    
    func makeOneOffPayment(account: Account, amount: Int, completion: @escaping (PaymentResult) -> ()) {
        operationQueue.addOperation { [weak self] in
            guard let url = URL(string: Environment.baseURL + "/oneoffpayments") else { return }
            var request = MoneyboxURLRequestBuilder.urlRequest(url: url)
            request.httpMethod = "POST"
            let parameters: [String: Any] = ["Amount": amount, "InvestorProductId": account.productId]
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
            if let token = self?.getSession()?.bearerToken {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                    completion(.failure(.networkError))
                    return
                }
                self?.oneOffPaymentCompleted(data: data, response: response, completion: completion)
            }
            task.resume()
        }
    }
    
    func oneOffPaymentCompleted(data: Data, response: HTTPURLResponse, completion: @escaping (PaymentResult) -> ()) {
        DispatchQueue.main.async {
            if let httpError = self.httpError(from: response) {
                completion(.failure(httpError))
            } else {
                let decoder = JSONDecoder()
                do {
                    let decodedResponse = try decoder.decode(PaymentResponse.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(.jsonError))
                }
            }
        }
    }
    
    // MARK: Helpers...
    
    private func httpError(from response: HTTPURLResponse) -> DataServiceError? {
        if (200 ... 299) ~= response.statusCode {
            return nil
        } else {
            switch response.statusCode {
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
