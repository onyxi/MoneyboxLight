//
//  LoginOperation.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation

/// LoginOperation performs an asynchronous network call to attempt login with the server with a given username and password
final class LoginOperation: Operation {
    
    let urlRequest: URLRequest
    private let completion: (LoginResult) -> ()
    
    /**
    - Parameter username: The email username of the account to attempt login for
    - Parameter password: the password of the account to attempt login for
    - Parameter completion: The function to be executed when the operation completes
    */
    init?(username: String, password: String, completion: @escaping (LoginResult) -> ()) {
        guard let url = URL(string: Environment.baseURL + "/users/login") else { return nil }
        var urlRequest = MoneyboxURLRequestBuilder.urlRequest(url: url)
        urlRequest.httpMethod = "POST"
        let parameters: [String: Any] = [
            "Email": username,
            "Password": password]
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        urlRequest.httpBody = jsonData
        self.urlRequest = urlRequest
        self.completion = completion
    }
    
    override func main() {
        guard !isCancelled else { return }
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: operationFinished)
        task.resume()
    }
    
    func operationFinished(_ data: Data?, response: URLResponse?, error: Error?) {
        DispatchQueue.main.async {
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                self.completion(.failure(.networkError))
                return
            }
            if let httpError = response.statusCode.asHttpError() {
                self.completion(.failure(httpError))
            } else {
                let decoder = JSONDecoder()
                do {
                    let decodedResponse = try decoder.decode(LoginResponse.self, from: data)
                    self.completion(.success(decodedResponse))
                } catch {
                    self.completion(.failure(.jsonError))
                }
            }
        }
    }
    
}
