//
//  StockTableViewCell.swift
//  StockList
//
//  Created by Artyom Kudryashov on 29.02.2020.
//

import UIKit

private let symbolViewSize: CGFloat = 44
private let sidePadding: CGFloat = 16

class StockTableViewCell: UITableViewCell {
    private let symbolView = UIView()
    private let symbolTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: 0xffffff)
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    private let titleTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: 0x333333)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 2
        return label
    }()
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xececec)
        return view
    }()

    static let reuseIdentifier: String = "_stockTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func bind(_ model: StockModel) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.cornerRadius = 12
        gradientLayer.colors = UIColor.cgGradient(for: model.symbol)
        gradientLayer.frame = .init(x: 0, y: 0, width: symbolViewSize, height: symbolViewSize)
        symbolView.layer.insertSublayer(gradientLayer, at: 0)
        symbolView.layer.cornerRadius = 12
        symbolTitle.text = model.symbol
        titleTitle.text = model.title
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.symbolView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        symbolTitle.text = nil
        titleTitle.text = nil
    }
}

extension StockTableViewCell {
    private func setupLayout() {
        [symbolView, symbolTitle, titleTitle, separator].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate(
            [
                symbolView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: sidePadding),
                symbolView.widthAnchor.constraint(equalToConstant: symbolViewSize),
                symbolView.heightAnchor.constraint(equalToConstant: symbolViewSize),
                symbolView.centerYAnchor.constraint(equalTo: centerYAnchor),

                symbolTitle.centerYAnchor.constraint(equalTo: symbolView.centerYAnchor),
                symbolTitle.centerXAnchor.constraint(equalTo: symbolView.centerXAnchor),

                titleTitle.leadingAnchor.constraint(equalTo: symbolView.trailingAnchor, constant: 8),
                titleTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
                titleTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -sidePadding*2),

                separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 68),
                separator.bottomAnchor.constraint(equalTo: bottomAnchor),
                separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
                separator.heightAnchor.constraint(equalToConstant: 1),
            ]
        )
        setNeedsLayout()
        layoutIfNeeded()
    }
}
