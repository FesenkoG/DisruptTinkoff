//
//  UISwitchBox.swift
//  TinkoffMidProject
//
//  Created by Artyom Kudryashov on 23.02.2020.
//  Copyright © 2020 TinkoffFintech. All rights reserved.
//

import UIKit

private let uiSwitchBoxHeight: CGFloat = 44

class UISwitchBox: UIView {
    // MARK: - Subviews

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.blackText
        return label
    }()

    private let innerSwitch: UISwitch = {
        let swi = UISwitch()
        swi.onTintColor = .accentBlue
        return swi
    }()

    // MARK: - Properties

    public var onSwitchChange: ((_ isOn: Bool) -> Void)?

    // MARK: - Init

    init(title: String, onSwitchChange: ((Bool) -> Void)? = nil) {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.text = title
        self.onSwitchChange = onSwitchChange

        setupLayout()

        innerSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        backgroundColor = UIColor(red: 0.941, green: 0.941, blue: 0.941, alpha: 1)
        layer.cornerRadius = 8

        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(innerSwitch)
        innerSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                self.heightAnchor.constraint(equalToConstant: uiSwitchBoxHeight),
                innerSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                innerSwitch.centerYAnchor.constraint(equalTo: centerYAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: innerSwitch.leadingAnchor, constant: -16),
                titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ]
        )
    }
}

// MARK: - UISwitch behaviour

extension UISwitchBox {
    public var isOn: Bool { innerSwitch.isOn }

    public func setOn(_ isOn: Bool, animated: Bool) {
        innerSwitch.setOn(isOn, animated: animated)
    }

    @objc private func switchValueChanged(sender: UISwitch) {
        onSwitchChange?(sender.isOn)
    }
}
