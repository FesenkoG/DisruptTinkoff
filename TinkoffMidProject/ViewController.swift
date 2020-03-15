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
        let sfSymbol: ((String) -> UIImage?) = { name -> UIImage? in
            let config = UIImage.SymbolConfiguration(weight: .semibold)
            return UIImage(systemName: name, withConfiguration: config)
        }

        let stockListPresenter = StockListPresenter()
        let stockListViewController = StockListViewController(presenter: stockListPresenter)
        stockListViewController.tabBarItem = .init(title: "Stocks", image: sfSymbol("rectangle.grid.1x2.fill"), tag: 0)

        let articlesView = ArticlesView()
            .environment(\.title, "Articles")
            .environmentObject(ArticlesViewModel())
        let articlesViewController = UIHostingController(rootView: articlesView)
        articlesViewController.tabBarItem = .init(title: "Articles", image: sfSymbol("doc.text.fill"), tag: 1)

        let controllers = [stockListViewController, articlesViewController]

        let tabBar = UITabBarController()
        tabBar.viewControllers = controllers.map {
            let controller = UINavigationController(rootViewController: $0)
            $0.navigationController?.navigationBar.prefersLargeTitles = true
            return controller
        }
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }
}
