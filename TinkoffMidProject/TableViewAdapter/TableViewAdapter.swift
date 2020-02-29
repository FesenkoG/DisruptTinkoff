//
//  TableViewAdapter.swift
//  TinkoffMidProject
//
//  Created by Georgy Fesenko on 2/29/20.
//  Copyright © 2020 TinkoffFintech. All rights reserved.
//

import UIKit

public protocol TableViewCellViewModel {
    func cellFor(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

public final class TableViewAdapter: NSObject {
    private let tableView: UITableView
    private var viewModels: [TableViewCellViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    public init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
    }

    public func set(viewModels: [TableViewCellViewModel]) {
        self.viewModels = viewModels
    }
}

extension TableViewAdapter: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModels[indexPath.row].cellFor(tableView: tableView, indexPath: indexPath)
    }
}

/*
 Example of the cell. ViewModel is not necessarily should be nested, but it's a preferred way of usage.

public class Cell: UITableViewCell, Reusable {
    public struct ViewModel: TableViewCellViewModel {
        let title: String

        public func cellFor(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
            let cell: Cell = tableView.dequeue(indexPath: indexPath)
            cell.setup(with: self)
            return cell
        }
    }

    private let titleLabel = UILabel()

    public func setup(with viewModel: ViewModel) {
        titleLabel.text = viewModel.title
    }
}
*/
