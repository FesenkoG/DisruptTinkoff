//
//  StockTableViewCell.swift
//  StockList
//
//  Created by Artyom Kudryashov on 29.02.2020.
//

import UIKit
import TinkoffKit

private let symbolViewSize: CGFloat = 44
private let sidePadding: CGFloat = 16

public final class StockTableViewCell: UITableViewCell, Reusable {
    public struct ViewModel: TableViewCellViewModel {
        public let cellHeight: CGFloat = 52.0

        public let symbol: String
        public let title: String
        public let tapAction: () -> Void

        public init(from model: StockDisplayModel, tapAction: @escaping () -> Void) {
            self.symbol = model.symbol
            self.title = model.title
            self.tapAction = tapAction
        }

        public func cellFor(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
            let cell: StockTableViewCell = tableView.dequeue(indexPath: indexPath)
            cell.update(with: self)
            return cell
        }

        public func didTap() {
            tapAction()
        }
    }

    private let symbolView = UIView()
    private let symbolTitle: UILabel = {
        let label = UILabel()
        label.textColor = .whiteText
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    private let titleTitle: UILabel = {
        let label = UILabel()
        label.textColor = .blackText
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 2
        return label
    }()
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .borderGrey
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    override public func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        let scale: CGFloat = highlighted ? 0.98 : 1

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.beginFromCurrentState, .curveEaseInOut], animations: {
            self.transform = .init(scaleX: scale, y: scale)
        }, completion: nil)
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func update(with viewModel: ViewModel) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.cornerRadius = 12
        gradientLayer.colors = UIColor.cgGradient(for: viewModel.symbol)
        gradientLayer.frame = .init(x: 0, y: 0, width: symbolViewSize, height: symbolViewSize)
        symbolView.layer.insertSublayer(gradientLayer, at: 0)
        symbolView.layer.cornerRadius = 12

        symbolTitle.text = viewModel.symbol
        titleTitle.text = viewModel.title.isEmpty ? "(no decription)" : viewModel.title
    }

    override public func prepareForReuse() {
        super.prepareForReuse()
        self.symbolView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        symbolTitle.text = nil
        titleTitle.text = nil
    }
}

extension StockTableViewCell {
    private func setupLayout() {
        selectedBackgroundView = UIView()
        backgroundColor = .clear

        [symbolView, symbolTitle, titleTitle, separator].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        symbolTitle.adjustsFontSizeToFitWidth = true
        symbolTitle.minimumScaleFactor = 0.5

        NSLayoutConstraint.activate(
            [
                symbolView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: sidePadding),
                symbolView.widthAnchor.constraint(equalToConstant: symbolViewSize),
                symbolView.heightAnchor.constraint(equalToConstant: symbolViewSize),
                symbolView.centerYAnchor.constraint(equalTo: centerYAnchor),

                symbolTitle.centerYAnchor.constraint(equalTo: symbolView.centerYAnchor),
                symbolTitle.leadingAnchor.constraint(equalTo: symbolView.leadingAnchor, constant: 4),
                symbolTitle.trailingAnchor.constraint(equalTo: symbolView.trailingAnchor, constant: -4),

                titleTitle.leadingAnchor.constraint(equalTo: symbolView.trailingAnchor, constant: 8),
                titleTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
                titleTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -sidePadding * 2),

                separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 68),
                separator.bottomAnchor.constraint(equalTo: bottomAnchor),
                separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
                separator.heightAnchor.constraint(equalToConstant: 1)
            ]
        )
    }
}
