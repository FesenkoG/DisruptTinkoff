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
import SwiftUI
import CompanyDetails

final class ViewController: UIViewController {
    private let topLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Путой экран"
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let navigationController = navigationController else { return }
        let coordinator = AuthenticationCoordinator(navigationController: navigationController)
        coordinator.completionHandler = {
            self.setupTabBar()
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

    private func setupTabBar() {
        let stockListPresenter = StockListPresenter()
        let stockListViewController = StockListViewController(presenter: stockListPresenter)
        stockListViewController.tabBarItem.title = "Stocks"

        let articlesView = ArticlesView()
        let articlesViewController = UIHostingController(
            rootView: articlesView
                .environmentObject(
                ArticlesViewModel()
            )
        )
        articlesViewController.tabBarItem.title = "News"

        let tabBar = UITabBarController()
        tabBar.viewControllers = [
            stockListViewController,
            articlesViewController
        ]

        let navigationController = UINavigationController(rootViewController: tabBar)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
}
