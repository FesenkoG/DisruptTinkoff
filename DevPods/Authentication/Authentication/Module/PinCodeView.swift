//
//  PinCodeView.swift
//  TinkoffMidProject
//
//  Created by Georgy Fesenko on 23/02/2020.
//  Copyright © 2020 TinkoffFintech. All rights reserved.
//

import UIKit

private let codeFieldSide: CGFloat = 44.0
private let codeLength: Int = 4

public final class PinCodeView: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 16.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let codeFields: [CodeView] = [CodeView(), CodeView(), CodeView(), CodeView()]
    private var pinNumbers: [Int?] = .init(repeating: nil, count: codeLength)

    var didEnterPin: ([Int]) -> Void = { _ in }

    public init() {
        super.init(frame: .zero)
        setupUI()
    }

    @discardableResult
    public override func becomeFirstResponder() -> Bool {
        codeFields.first?.becomeFirstResponder()
        return super.becomeFirstResponder()
    }

    public func clear() {
        codeFields.forEach { $0.clearTextField() }
        pinNumbers = .init(repeating: nil, count: codeLength)
    }

    private func setupUI() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate(
            [
                stackView.topAnchor.constraint(equalTo: topAnchor),
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
                stackView.leftAnchor.constraint(equalTo: leftAnchor),
                stackView.rightAnchor.constraint(equalTo: rightAnchor)
            ]
        )

        codeFields.enumerated().forEach { index, codeField in
            NSLayoutConstraint.activate(
                [
                    codeField.widthAnchor.constraint(equalToConstant: codeFieldSide),
                    codeField.heightAnchor.constraint(equalToConstant: codeFieldSide)
                ]
            )
            stackView.addArrangedSubview(codeField)

            codeField.didChangeValue = { [weak self] value in
                guard let self = self else { return }
                self.pinNumbers[index] = value
                let pinNumbers = self.pinNumbers.compactMap { $0 }
                guard pinNumbers.count < 4 else {
                    return self.didEnterPin(pinNumbers)
                }

                let nextIndex = index + 1

                if value == nil {
                    self.codeFields.forEach { $0.clearTextField() }
                    self.codeFields.first?.becomeFirstResponder()
                } else if value != nil && nextIndex < codeLength {
                    self.codeFields[nextIndex].becomeFirstResponder()
                } else if value != nil && nextIndex == codeLength {
                    guard pinNumbers.count == 4 else {
                        return
                    }
                    self.didEnterPin(pinNumbers)
                }
            }
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class CodeView: UIView, UITextFieldDelegate {
    private let textField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tintColor = .black
        textField.textAlignment = .center
        return textField
    }()

    var didChangeValue: (Int?) -> Void = { _ in }
    var didBecomeFirstResponder: () -> Void = {}

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false

        layer.cornerRadius = 8.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.borderGrey.cgColor

        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 3)

        backgroundColor = .white

        addSubview(textField)

        NSLayoutConstraint.activate(
            [
                textField.leadingAnchor.constraint(equalTo: leadingAnchor),
                textField.trailingAnchor.constraint(equalTo: trailingAnchor),
                textField.topAnchor.constraint(equalTo: topAnchor),
                textField.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        )

        textField.delegate = self
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @discardableResult
    override func becomeFirstResponder() -> Bool {
        textField.becomeFirstResponder()
        return super.becomeFirstResponder()
    }

    func clearTextField() {
        textField.text = nil
    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            guard updatedText.count < 2 else {
                    return false
            }

            textField.text = updatedText
            if let intValue = Int(updatedText) {
                didChangeValue(intValue)
            } else {
                didChangeValue(nil)
            }
        }

        return false
    }
}
