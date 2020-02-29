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
            view?.filteredStocks = view?.stocks ?? []
            return
        }
        let stocks = view?.stocks
        view?.filteredStocks = stocks?.filter { $0.symbol.contains(substring) || $0.title.contains(substring) } ?? []
        print("updateSearchResults", substring)
    }

    public func didDismissSearchController() {
        view?.filteredStocks = view?.stocks ?? []
    }
}

extension StockListPresenter {
    public func getStocks() {
        self.view?.showSpinner()

        // TODO: Implement network request here:
        let successfulQuery = true
        let newStocks = StockModel.generate()
        view?.stocks = newStocks
        view?.filteredStocks = newStocks

        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
            if successfulQuery {
                self.view?.showTable()
            } else {
                self.view?.showError()
            }
        }
    }
}
