//
//  MakeOneOffPaymentOperation.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 20/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import Foundation

final class MakeOneOffPaymentOperation: Operation {
    
    let urlRequest: URLRequest
    private let completion: (PaymentResult) -> ()
    
    init?(account: Account, amount: Int, bearerToken: String, completion: @escaping (PaymentResult) -> ()) {
        guard let url = URL(string: Environment.baseURL + "/oneoffpayments") else { return nil }
        var urlRequest = MoneyboxURLRequestBuilder.urlRequest(url: url)
        urlRequest.httpMethod = "POST"
        let parameters: [String: Any] = [
            "Amount": amount,
            "InvestorProductId": account.productId]
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        urlRequest.httpBody = jsonData
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
                    let decodedResponse = try decoder.decode(PaymentResponse.self, from: data)
                    self.completion(.success(decodedResponse))
                } catch {
                    self.completion(.failure(.jsonError))
                }
            }
        }
    }
}
