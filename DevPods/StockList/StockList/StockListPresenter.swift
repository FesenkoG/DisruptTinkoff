//
//  StockListPresenter.swift
//  Authentication
//
//  Created by Artyom Kudryashov on 28.02.2020.
//

import UIKit

public protocol StockListPresenterProtocol: AnyObject {
    var view: StockListProtocol? { get set }

    func viewDidLoad()
    func updateSearchResults(for substring: String)

    func didDismissSearchController()
    func errorButtonDidTapped()

    func getStocks()
}

public final class StockListPresenter: StockListPresenterProtocol {
    public weak var view: StockListProtocol?

    private var stocks: [StockSymbol] = []

    private let apiService = StocksApiService()
    private let storageService = StockSymbolStorgeService()

    public init() { }

    public func viewDidLoad() {
        view?.setupTitle(for: ExchangeCode("US"))

        stocks = storageService.loadStockSymbols()
        view?.showTable(with: stocks.map(StockDisplayModel.init))
        getStocks()
    }

    public func errorButtonDidTapped() {
        getStocks()
    }
}

extension StockListPresenter {
    public func updateSearchResults(for substring: String) {
        guard !substring.isEmpty else {
            view?.showTable(with: stocks.map(StockDisplayModel.init))
            return
        }

        let filteredStocks = stocks.filter { $0.symbol.contains(substring) || $0.description.contains(substring) }
        view?.showTable(with: filteredStocks.map(StockDisplayModel.init))
    }

    public func didDismissSearchController() {
        view?.showTable(with: stocks.map(StockDisplayModel.init))
    }
}

extension StockListPresenter {
    public func getStocks() {
        if stocks.isEmpty {
            self.view?.showLoading()
        }

        apiService.fetchStockSymbols(
            exchangeCode: "US"
        ) {
            switch $0 {
            case .success(let stocks):
                self.storageService.persist(stockSymbols: stocks)
                self.stocks = stocks
                self.view?.showTable(with: stocks.map(StockDisplayModel.init))
            case .failure:
                self.view?.showError()
            }
        }
    }
}
