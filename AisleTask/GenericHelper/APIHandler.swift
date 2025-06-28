//
//  APIHandler.swift
//  AisleTask
//
//  Created by K V Jagadeesh babu on 26/06/25.
//

import Foundation
import UIKit

class APIHandler {
    static let shared = APIHandler()
 
// MARK: Post API

    func postAPI<T: Codable>(url: String, parameters:[String: Any] , complationHandler: @escaping(Result< T, Error>) -> Void) {
        
        guard let urlStr = URL(string: url) else {
            complationHandler(.failure(NSError(domain: "Invalid URL ", code: 0)))
            return
        }
        var request = URLRequest(url: urlStr)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        request.httpBody = body
        let apiresponse = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                complationHandler(.failure("No data" as! Error))
                return
            }
            if let error = error {
                complationHandler(.failure(error))
                return
            }
            do {
                let apiData = try JSONDecoder().decode(T.self, from: data)
                complationHandler(.success(apiData))
            } catch {
                if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) {
                    print("Raw Response JSON: \(jsonObject)")
                }
                complationHandler(.failure(error))

            }
        }
        apiresponse.resume()
    }
    
   
// MARK: Get API

    func GetAPI<T:Codable>(Url: String, Header:[String: Any], complationHandler: @escaping(Result<T, Error>) -> Void ) {
        guard let urlStr = URL(string: Url) else {
            complationHandler(.failure(NSError(domain: "Invalid URL ", code: 0)))
            return
        }
        var request = URLRequest(url: urlStr)
        request.httpMethod = "GET"
        
        for (key, value) in Header {
            if let headerValue = value as? String {
                request.setValue(headerValue, forHTTPHeaderField: key)
            }
        }
        print("Final URL: \(urlStr)")
            print("Headers: \(Header)")

        let apiresponse = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                complationHandler(.failure("No data" as! Error))
                return
            }
            print("Data response \(String(data: data, encoding: .utf8))")
            if let error = error {
                complationHandler(.failure(error))
                return
            }
            do {
                let apiData = try JSONDecoder().decode(T.self, from: data)
                complationHandler(.success(apiData))
            } catch {
                if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) {
                    print("Raw Response JSON: \(jsonObject)")
                }
                complationHandler(.failure(error))

            }
        }
        apiresponse.resume()
        
    }
    
}
