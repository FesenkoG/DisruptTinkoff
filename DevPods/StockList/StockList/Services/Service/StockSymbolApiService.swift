//
//  StockSymbolApiService.swift
//  TinkoffMidProject
//
//  Created by a.gachkovskaya on 01.03.2020.
//  Copyright © 2020 TinkoffFintech. All rights reserved.
//

import TinkoffNetwork

final class StocksApiService {
    private let token = "bpdp96vrh5rauiikjjn0"
    private let baseUrl = "https://finnhub.io/api/v1/stock"

    private let networkClient = NetworkClient()

    func fetchExchanges(completion: @escaping (Result<[StockExchange], Error>) -> Void) {
        let url = URL(string: "\(baseUrl)/exchange?token=\(token)")!
        let request = URLRequest(url: url)
        networkClient.fetch(
            request,
            completion: completion
        )
    }

    func fetchStockSymbols(
        exchangeCode: ExchangeCode,
        completion: @escaping (Result<[StockSymbol], Error>) -> Void
    ) {
        let url = URL(string: "\(baseUrl)/symbol?exchange=\(exchangeCode)&token=\(token)")!
        let request = URLRequest(url: url)
        networkClient.fetch(
            request,
            completion: completion
        )
    }
}
