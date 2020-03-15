//
//  CompanyApiService.swift
//  CompanyDetails
//
//  Created by Artyom Kudryashov on 14.03.2020.
//

import Combine
import TinkoffNetwork

public class CompanyApiService {
    private let token = "bpmnqavrh5rf2as80pc0"
    private let baseUrl = "https://finnhub.io/api/v1"

    private let networkClient = NetworkClient()
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    public init() {}

    public func fetchCompany(
        symbol: String,
        completion: @escaping (Result<Company, Error>) -> Void
    ) {
        let url = URL(string: "\(baseUrl)/stock/profile?symbol=\(symbol)&token=\(token)")!
        let request = URLRequest(url: url)
        networkClient.fetch(
            request,
            completion: completion
        )
    }

    public func combineFetchCompany(symbol: String) -> AnyPublisher<Company, Error> {
        let url = URL(string: "\(baseUrl)/stock/profile?symbol=\(symbol)&token=\(token)")!
        let request = URLRequest(url: url)

        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: Company.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    public func combineFetchArticles(symbol: String) -> AnyPublisher<[Article], Error> {
        let url = URL(string: "\(baseUrl)/news/\(symbol)?token=\(token)")!
        let request = URLRequest(url: url)

        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: [Article].self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
