//
//  NetworkClient.swift
//  Network
//
//  Created by a.gachkovskaya on 01.03.2020.
//  Copyright © 2020 a.gachkovskaya. All rights reserved.
//

import Foundation

public final class NetworkClient {

    public init() { }

    public func fetch<T: Decodable>(
        _ request: URLRequest,
        completion: @escaping (Result<T,Error>) -> Void
    ) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                return DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }

            if let data = data {
                do {
                    let model = try JSONDecoder().decode(
                        T.self,
                        from: data
                    )
                    DispatchQueue.main.async {
                        completion(.success(model))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }.resume()
    }
}
