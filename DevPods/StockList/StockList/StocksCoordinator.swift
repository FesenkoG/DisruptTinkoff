//
//  StocksCoordinator.swift
//  StockList
//
//  Created by Georgy Fesenko on 3/2/20.
//  Copyright © 2020 disrupt. All rights reserved.
//

import UIKit

public final class StocksMainCoordinator {
    private let rootViewController: UIViewController

    public init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }

    public func showStocksList() {
        let presenter = StockListPresenter()
        let viewController = StockListViewController(presenter: presenter)

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen

        rootViewController.present(navigationController, animated: true)
    }
}
