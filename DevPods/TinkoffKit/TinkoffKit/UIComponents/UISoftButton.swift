//
//  UISoftButton.swift
//  TinkoffMidProject
//
//  Created by Artyom Kudryashov on 23.02.2020.
//  Copyright © 2020 TinkoffFintech. All rights reserved.
//

import UIKit

/**
You use UISoftButton as common UIButton.

It has `.common` style by default.
Change `isEnabled` property to `false` to lock interaction with it.
Also, height is already set up **44px**.

 ## Disabling button

    let button = UISoftButton(style: .accent, title: "Buy item")
    button.isEnabled = false
*/
public class UISoftButton: UIButton {
    public enum Style {
        case accent
        case common
        case danger
    }

    // MARK: - Properties

    private let uiSoftButtonHeight: CGFloat = 44
    public var style: Style = .accent {
        didSet { updateColors() }
    }
    override public var isEnabled: Bool {
        didSet { updateColors() }
    }
    override public var isHighlighted: Bool {
        didSet { updateColors() }
    }

    // MARK: - Init

    public init(style: Style = .common, title: String = "") {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        layer.cornerRadius = 8
        titleLabel?.font = UIFont.systemFont(ofSize: 14)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: uiSoftButtonHeight).isActive = true

        updateColors()
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Handling

    public func updateColors() {
        guard isEnabled else {
            self.backgroundColor = .commonGray
            self.setTitleColor(.disabledText, for: .normal)
            return
        }

        switch style {
        case .accent:
            self.setTitleColor(.whiteText, for: .normal)
            self.backgroundColor = isHighlighted
                ? .accentBlueHighlighted
                : .accentBlue
        case .common:
            self.setTitleColor(.blackText, for: .normal)
            self.backgroundColor = isHighlighted
                ? .commonGrayHighlighted
                : .commonGray
        case .danger:
            self.setTitleColor(.whiteText, for: .normal)
            self.backgroundColor = isHighlighted
                ? .dangerRedHighlighted
                : .dangerRed
        }
    }
}
