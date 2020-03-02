//
//  ViewController.swift
//  TinkoffMidProject
//
//  Created by Georgy Fesenko on 19/02/2020.
//  Copyright © 2020 TinkoffFintech. All rights reserved.
//

import UIKit
import Auth
import StockList

final class ViewController: UIViewController {
    // MARK: - Private properties

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

        guard let navigationController = navigationController else { return }
        let coordinator = AuthenticationCoordinator(navigationController: navigationController)
        coordinator.completionHandler = {
            StocksMainCoordinator(rootViewController: self).showStocksList()
        }
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
