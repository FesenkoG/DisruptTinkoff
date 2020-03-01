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

    private var stocks: [StockModel] = []

    public init() { }

    public func viewDidLoad() {
        view?.setupHeader("Companies")
        view?.setupSubtitle("US exchanges")

        getStocks()
    }

    public func errorButtonDidTapped() {
        getStocks()
    }
}

extension StockListPresenter {
    public func updateSearchResults(for substring: String) {
        guard !substring.isEmpty else {
            view?.showTable(with: stocks)
            return
        }

        let filteredStocks = stocks.filter { $0.symbol.contains(substring) || $0.title.contains(substring) }
        view?.showTable(with: filteredStocks)
    }

    public func didDismissSearchController() {
        view?.showTable(with: stocks)
    }
}

extension StockListPresenter {
    public func getStocks() {
        self.view?.showLoading()

        // TODO: Implement network request here:
        let successfulQuery = true
        stocks = StockModel.generate()

        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (_) in
            if successfulQuery {
                self.view?.showTable(with: self.stocks)
            } else {
                self.view?.showError()
            }
        }
    }
}
