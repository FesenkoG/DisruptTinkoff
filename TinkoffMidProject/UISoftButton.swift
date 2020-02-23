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
class UISoftButton: UIButton {
    enum Style {
        case accent
        case common
        case danger
    }

    // MARK: - Properties

    private let uiSoftButtonHeight: CGFloat = 44
    var style: Style = .accent {
        didSet { updateColors() }
    }
    override var isEnabled: Bool {
        didSet { updateColors() }
    }
    override var isHighlighted: Bool {
        didSet { updateColors() }
    }


    // MARK: - Init

    init(style: Style = .common, title: String = "") {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        layer.cornerRadius = 8
        titleLabel?.font = R.font.sfProRoundedSemibold(size: 14)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: uiSoftButtonHeight).isActive = true

        updateColors()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Handling

    func updateColors() {
        guard isEnabled else {
            self.backgroundColor = R.color.uiSoftButtonDisabledBackground()
            self.setTitleColor(R.color.uiSoftButtonDisabledTitle(), for: .normal)
            return
        }

        switch style {
        case .accent:
            self.setTitleColor(R.color.uiSoftButtonTitleLight(), for: .normal)
            self.backgroundColor = isHighlighted
                ? R.color.uiSoftButtonAccentHighlighted()
                : R.color.uiSoftButtonAccent()
        case .common:
            self.setTitleColor(R.color.uiSoftButtonTitleDark(), for: .normal)
            self.backgroundColor = isHighlighted
                ? R.color.uiSoftButtonCommonHighlighted()
                : R.color.uiSoftButtonCommon()
        case .danger:
            self.setTitleColor(R.color.uiSoftButtonTitleLight(), for: .normal)
            self.backgroundColor = isHighlighted
                ? R.color.uiSoftButtonDangerHighlighted()
                : R.color.uiSoftButtonDanger()
        }
    }
}
