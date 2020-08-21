//
//  GetAccountsOperation.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation

/// GetAccountsOperation performs an asynchronous network call to attempt retrieval of the user's accounts info
final class GetAccountsOperation: Operation {
    
    let urlRequest: URLRequest
    private let completion: (AccountsResult) -> ()
    
    /**
    - Parameter bearerToken: The auth token required to access the endpoint
    - Parameter completion: The function to be executed when the operation completes
    */
    init?(bearerToken: String, completion: @escaping (AccountsResult) -> ()) {
        guard let url = URL(string: Environment.baseURL + "/investorproducts") else { return nil }
        var urlRequest = MoneyboxURLRequestBuilder.urlRequest(url: url)
        urlRequest.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
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
                    let decodedResponse = try decoder.decode(AccountsResponse.self, from: data)
                    self.completion(.success(decodedResponse))
                } catch {
                    self.completion(.failure(.jsonError))
                }
            }
        }
    }
    
}
