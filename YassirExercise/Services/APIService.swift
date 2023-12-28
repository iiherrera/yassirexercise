//
//  APIService.swift
//  YassirExercise
//
//  Created by Iván Herrera on 12/26/23.
//

import Foundation

enum FetchError: Error {
    case invalidUrl
    case failedRequest(error: Error?)
    case errorDecode
    case unknownError
}

class APIService {
    // This generic function downloads a json from the provided URL and deserializes its content
    // into the type provided. It calls a completion handler either with a "T" type object
    // or a fetch error
    func fetch<T:Decodable>(url: String, method: String, type: T.Type, completion: @escaping (Result<T, FetchError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                // If there is an error in the request we send a failed request error
                // containing the actual error
                completion(.failure(.failedRequest(error: error)))
            } else if let data = data {
                do {
                    let models = try JSONDecoder().decode(T.self, from: data)
                    // If the decoding is successful we send the specified "T" object
                    completion(.success(models))
                } catch {
                    // If the decoding fails we send a decoding error
                    completion(.failure(.errorDecode))
                }
            } else {
                // If there is no error and no data, we send an unknown error
                completion(.failure(.unknownError))
            }
        }.resume()
    }
    
    
}
