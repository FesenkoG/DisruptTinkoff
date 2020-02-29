//
//  StockListViewController.swift
//  ComplicatedApp
//
//  Created by Artyom Kudryashov on 28.02.2020.
//  Copyright © 2020 Education. All rights reserved.
//

import UIKit

private let sidePadding: CGFloat = 16

public protocol StockListProtocol: AnyObject {
    var stocks: [StockModel] { get set }
    var filteredStocks: [StockModel] { get set }
    func setupHeader(_ text: String)
    func setupSubtitle(_ text: String)
    func showSpinner()
    func showTable()
    func showError()
}

public final class StockListViewController: UIViewController {
    // MARK: - Subviews
    private let headerTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: 0x333333)
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    private let subTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: 0x999999)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView: UITableView = {
        let table = UITableView()
//        table.alpha = 0
        return table
    }()
    private let indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        return indicator
    }()
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
    public var stocks: [StockModel] = []
    public var filteredStocks: [StockModel] = [] {
        didSet { tableView.reloadData() }
    }

    // MARK: - Lifecycle

    public init(presenter: StockListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        presenter.view = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    public func setupHeader(_ text: String) {
        headerTitle.text = text
    }

    public func setupSubtitle(_ text: String) {
        subTitle.text = text
    }

    public func showSpinner() {
        indicatorView.startAnimating()

        UIView.animate(withDuration: 0.22) {
            self.tableView.alpha = 0
            self.errorTitle.alpha = 0
            self.errorButton.alpha = 0
        }
    }

    public func showTable() {
        indicatorView.stopAnimating()

        UIView.animate(withDuration: 0.22) {
            self.tableView.alpha = 1
            self.errorTitle.alpha = 0
            self.errorButton.alpha = 0
        }
    }

    public func showError() {
        indicatorView.stopAnimating()

        UIView.animate(withDuration: 0.22) {
            self.tableView.alpha = 0
            self.errorTitle.alpha = 1
            self.errorButton.alpha = 1
        }
    }
}

// MARK: - TableView & SearchController

extension StockListViewController: UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchControllerDelegate {

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(StockTableViewCell.self, forCellReuseIdentifier: StockTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredStocks.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.reuseIdentifier, for: indexPath) as? StockTableViewCell {
            cell.bind(stocks[indexPath.row])
            return cell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "ERR"
            return cell
        }
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }

    public func updateSearchResults(for searchController: UISearchController) {
        print("outer")
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

        [tableView, headerTitle, subTitle, indicatorView, errorButton, errorTitle].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        tableView.alpha = 0
        tableView.backgroundView = UIView()
        tableView.backgroundColor = .clear
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.barTintColor = UIColor(hex: 0xf3f2f8)
        searchController.searchBar.backgroundColor = UIColor(hex: 0xf3f2f8)
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.directionalLayoutMargins = .init(top: 0, leading: sidePadding, bottom: 40, trailing: sidePadding)

        NSLayoutConstraint.activate(
            [
                tableView.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 12),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                headerTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: sidePadding),
                headerTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidePadding),
                headerTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sidePadding),
                subTitle.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 2),
                subTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidePadding),
                subTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sidePadding),

                indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

                errorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                errorButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                errorTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                errorTitle.bottomAnchor.constraint(equalTo: errorButton.topAnchor, constant: -12),
            ]
        )
    }
}

public struct StockModel {
    let symbol: String
    let title: String
}

extension StockModel {
    static func generate() -> [StockModel] {
        var stocks: [StockModel] = []
        for _ in 0..<25 {
            let s = StockModel(symbol: randStr(length: 2), title: randStr(length: 64))
            stocks.insert(s, at: 0)
        }
        return stocks
    }
}
func randStr(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map{ _ in letters.randomElement()! })
}
