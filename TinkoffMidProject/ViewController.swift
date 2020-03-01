//
//  ViewController.swift
//  TinkoffMidProject
//
//  Created by Georgy Fesenko on 19/02/2020.
//  Copyright © 2020 TinkoffFintech. All rights reserved.
//

import UIKit
import Auth

final class ViewController: UIViewController {
    // MARK: - Private properties
    let apiService = StocksApiService()

    let service = CoreDataService()

    private let topLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Путой экран"
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        apiService.fetchExchanges { result in
            switch result {
            case .success(let exchanges):
                let firstCode = exchanges.first!.code
                self.apiService.fetchStockSymbols(exchangeCode: firstCode) {
                    switch $0 {
                    case .success(let symbols):
                        let firstTen = symbols.prefix(10)

                        firstTen.forEach { symbol in
                            self.service.persist(
                                updateWith: { (dbSymbol: DBStockSymbol) in
                                    dbSymbol.displaySymbol = symbol.displaySymbol
                                    dbSymbol.symbolDescription = symbol.description
                                    dbSymbol.symbol = symbol.symbol
                            },
                                predicate: NSPredicate(format: "symbol = %@", "\(symbol.symbol)")
                            )
                        }

                        let symbols: [DBStockSymbol]? = self.service.fetch(predicate: nil)
                        print(symbols!.map { $0.symbolDescription })
                    default:
                        break
                    }
                }
            case .failure(let error):
                print(error)
            }
        }

        guard let navigationController = navigationController else { return }
        let coordinator = AuthenticationCoordinator(navigationController: navigationController)
        coordinator.proceedWithAuthentication()
        view.backgroundColor = .white
        view.addSubview(topLabel)

        NSLayoutConstraint.activate(
            [
                topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                topLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ]
        )
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
