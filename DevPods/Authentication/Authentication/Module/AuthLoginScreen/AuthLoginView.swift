//
//  AuthLoginView.swift
//  Authentication
//
//  Created by MacBook-Игорь on 24.02.2020.
//

import UIKit

protocol AuthLoginViewDelegate: class {
    func validate(text: String?, inRange: NSRange, rString: String, type: Int) -> Bool
}

final class AuthLoginView: UIView {

    weak var delegate: AuthLoginViewDelegate?

    private let topLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.systemFont(ofSize: 24)
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.text = "Вход"
        tl.textAlignment = .center
        return tl
    }()

    private let loginTextField: PlainTextField = {
        let ltf = PlainTextField(title: loginText.title,
                                 placeholder: loginText.placeholder)
        return ltf
    }()

    private let passwordTextField: PlainTextField = {
        let ptf = PlainTextField(title: passwordText.title,
                                 placeholder: passwordText.placeholder)
           return ptf
       }()

    private let signInButton: UISoftButton = {
        let sb = UISoftButton(title: "Войти")
//        sb.isEnabled = false
        return sb
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        loginTextField.delegate = self
        loginTextField.tag = textFieldType.login
        passwordTextField.delegate = self
        passwordTextField.tag = textFieldType.password
    }

    private func setupUI() {
        backgroundColor = .white

        addSubview(topLabel)
        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(signInButton)

        NSLayoutConstraint.activate([

            topLabel.topAnchor.constraint(equalTo: topAnchor),
            topLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                              constant: leadingTrailingSpacing),
            topLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                               constant: -leadingTrailingSpacing),
            topLabel.heightAnchor.constraint(equalToConstant: 29),

            loginTextField.topAnchor.constraint(equalTo: topLabel.bottomAnchor,
                                                constant: elementSpacing),
            loginTextField.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                    constant: leadingTrailingSpacing),
            loginTextField.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                     constant: -leadingTrailingSpacing),

            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor,
                                                   constant: elementSpacing),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                       constant: leadingTrailingSpacing),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                        constant: -leadingTrailingSpacing),

            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,
                                              constant: elementSpacing),
            signInButton.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                  constant: leadingTrailingSpacing),
            signInButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                   constant: -leadingTrailingSpacing),
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AuthLoginView: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        print()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        print()
    }

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let plainTextField = textField as? PlainTextField else { return false }
        return delegate?.validate(text: textField.text,
                                  inRange: range,
                                  rString: string,
                                  type: plainTextField.tag) ?? false
    }
}

private let loginText: (title: String, placeholder: String) = ("email", "Логин")
private let passwordText: (title: String, placeholder: String) = ("password", "Пароль")
private let leadingTrailingSpacing: CGFloat = 52.0
private let elementSpacing: CGFloat = 16.0
private let textFieldType: (login: Int, password: Int) = (0, 1)
