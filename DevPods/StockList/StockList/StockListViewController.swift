//
//  StockListViewController.swift
//  ComplicatedApp
//
//  Created by Artyom Kudryashov on 28.02.2020.
//  Copyright © 2020 Education. All rights reserved.
//

import UIKit
import TinkoffKit

private let sidePadding: CGFloat = 16

public protocol StockListProtocol: AnyObject {
    func setupTitle(for exchangeCode: String)
    func showTable(with stocks: [StockDisplayModel])
    func showLoading()
    func showError()
}

public final class StockListViewController: UIViewController, SpinnerShowingProtocol {
    // MARK: - Subviews
    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView = UITableView()
    public var indicatorView = UIActivityIndicatorView(style: .large)
    private let errorTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: 0x999999)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Ошибка загрузки"
        label.alpha = 0
        return label
    }()
    private let errorButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(errorButtonDidTapped), for: .touchUpInside)
        button.setTitle("Попробовать еще раз", for: .normal)
        button.alpha = 0
        return button
    }()

    // MARK: - Properties

    private let presenter: StockListPresenter
    private let tableViewAdapter: TableViewAdapter

    // MARK: - Lifecycle

    public init(presenter: StockListPresenter) {
        self.presenter = presenter
        self.tableViewAdapter = TableViewAdapter(tableView: tableView)
        super.init(nibName: nil, bundle: nil)
        presenter.view = self
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.barTintColor = UIColor(hex: 0xf3f2f8)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(hex: 0x333333),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .semibold)
        ]

        navigationItem.searchController = searchController
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setupTableView()
        presenter.viewDidLoad()
    }

    @objc func errorButtonDidTapped() {
        presenter.errorButtonDidTapped()
    }
}

extension StockListViewController: StockListProtocol {
    public func setupTitle(for exchangeCode: String) {
        navigationItem.title = "Companies \(exchangeCode)"
    }

    public func showLoading() {
        showSpinner()

        UIView.animate(withDuration: 0.22) {
            self.tableView.alpha = 0
            self.errorTitle.alpha = 0
            self.errorButton.alpha = 0
        }
    }

    public func showTable(with stocks: [StockDisplayModel]) {
        hideSpinner()

        tableViewAdapter.set(viewModels: stocks.map(StockTableViewCell.ViewModel.init))

        UIView.animate(withDuration: 0.22) {
            self.tableView.alpha = 1
            self.errorTitle.alpha = 0
            self.errorButton.alpha = 0
        }
    }

    public func showError() {
        hideSpinner()

        UIView.animate(withDuration: 0.22) {
            self.tableView.alpha = 0
            self.errorTitle.alpha = 1
            self.errorButton.alpha = 1
        }
    }
}

// MARK: - UISearchController

extension StockListViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    private func setupTableView() {
        tableView.register(StockTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
    }

    public func updateSearchResults(for searchController: UISearchController) {
        presenter.updateSearchResults(for: searchController.searchBar.text ?? "")
    }

    public func didDismissSearchController(_ searchController: UISearchController) {
        presenter.didDismissSearchController()
    }
}

// MARK: - Layout

extension StockListViewController {
    private func setupLayout() {
        view.backgroundColor = UIColor(hex: 0xf3f2f8)

        [tableView, indicatorView, errorButton, errorTitle].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        tableView.alpha = 0
        tableView.backgroundView = UIView()
        tableView.backgroundColor = .clear
        searchController.searchBar.barTintColor = UIColor(hex: 0xf3f2f8)
        searchController.searchBar.backgroundColor = UIColor(hex: 0xf3f2f8)
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.directionalLayoutMargins = .init(top: 0, leading: sidePadding, bottom: 0, trailing: sidePadding)

        NSLayoutConstraint.activate(
            [
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

                indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

                errorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                errorButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                errorTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                errorTitle.bottomAnchor.constraint(equalTo: errorButton.topAnchor, constant: -12)
            ]
        )
    }
}

public struct StockDisplayModel {
    public let symbol: String
    public let title: String

    init(from dto: StockSymbol) {
        self.symbol = dto.displaySymbol
        self.title = dto.description
    }
}
