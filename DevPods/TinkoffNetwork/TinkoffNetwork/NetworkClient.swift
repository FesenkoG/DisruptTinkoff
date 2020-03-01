//
//  NetworkClient.swift
//  Network
//
//  Created by a.gachkovskaya on 01.03.2020.
//  Copyright © 2020 a.gachkovskaya. All rights reserved.
//

import Foundation

public final class NetworkClient {
    public func fetch<T: Decodable>(
        _ request: URLRequest,
        completion: @escaping (Result<T,Error>) -> Void
    ) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data {
                do {
                    let model = try JSONDecoder().decode(
                        T.self,
                        from: data
                    )
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
