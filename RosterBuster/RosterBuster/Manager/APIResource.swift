//
//  APIManager.swift
//  APIManager
//
//  Created by Rahul on 05/10/21.
//

import Foundation

enum RequestError: Error {
    case urlInvalid
    case requestFailed(error: Error)
    case decodingFailed(error: Error)
    case noData
}

struct APIResource<Model: Decodable> {
    
    let url: String
    
    func request(completion: @escaping (Result<Model, RequestError>)->Void) {
        guard let url = URL(string: url) else {
            completion(.failure(RequestError.urlInvalid))
            return
        }
        
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration)
        
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.requestFailed(error: error)))
                return
            }
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(Model.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingFailed(error: error)))
                }
            } else {
                completion(.failure(.noData))
            }
        }
        .resume()
    }
    
}

