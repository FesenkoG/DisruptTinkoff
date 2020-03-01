//
//  AuthLoginViewController.swift
//  Authentication
//
//  Created by Artyom Kudryashov on 26.02.2020.
//  Copyright © 2020 TinkoffFintech. All rights reserved.
//

import UIKit
import TinkoffKit

public protocol LoginProtocol: AnyObject {
    func setupTitle(_ title: String)
    func setupTextFieldTitles(_ forLogin: String, _ forPassword: String)
    func setupTextFieldErrors(_ forLogin: String?, _ forPassword: String?)
    func setupButtonTitle(_ title: String)
    func setButtonEnabled(_ isEnabled: Bool)
}

public final class LoginViewController: UIViewController {
    private let topLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Вход"
        label.textAlignment = .center
        return label
    }()
    private let loginTextField: PlainTextField = {
        let ltf = PlainTextField(title: "", placeholder: "")
        ltf.addTarget(self, action: #selector(textFieldEditingDidEnd), for: .editingDidEnd)
        ltf.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        return ltf
    }()
    private let passwordTextField: PlainTextField = {
        let ptf = PlainTextField(title: "", placeholder: "")
        ptf.isSecureTextEntry = true
        ptf.addTarget(self, action: #selector(textFieldEditingDidEnd), for: .editingDidEnd)
        ptf.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        return ptf
    }()
    private let signInButton: UISoftButton = {
        let button = UISoftButton(title: "Войти")
        button.isEnabled = false
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        return button
    }()
    private var switchBox = UISwitchBox(title: "Задать пин")

    public enum TypOfTextField {
        case login, password
    }
    private let presenter: LoginPresenter

    public init(presenter: LoginPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        presenter.view = self
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()

        switchBox = UISwitchBox(
            title: "Задать пин",
            onSwitchChange: { isOn in
                self.presenter.onPinSwitchChange(isOn)
            }
        )

        prepareUI()
        hideKeyboardOnBackgroundTap()
    }

    private func prepareUI() {
        view.backgroundColor = .white

        let stackView = UIStackView(arrangedSubviews: [topLabel, loginTextField, passwordTextField, signInButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.setCustomSpacing(24, after: topLabel)

        view.addSubview(stackView)
        view.addSubview(switchBox)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        switchBox.translatesAutoresizingMaskIntoConstraints = false

        let safeScreenHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
        let safeScreenWidth = view.safeAreaLayoutGuide.layoutFrame.size.width
        let topInset = safeScreenHeight * 0.2
        let sideInset = safeScreenWidth * 0.2

        NSLayoutConstraint.activate(
            [
                stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topInset),
                stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: sideInset),
                stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -sideInset),
                switchBox.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
                switchBox.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: sideInset),
                switchBox.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -sideInset)
            ]
        )
    }

    @objc func textFieldEditingDidEnd(_ ptf: PlainTextField) {
        presenter.editingDidEnd(loginTextField, passwordTextField, editedTextField: ptf == loginTextField ? .login : .password)
    }

    @objc func textFieldEditingChanged(_ ptf: PlainTextField) {
        presenter.editingChanged(loginTextField, passwordTextField, editedTextField: ptf == loginTextField ? .login : .password)
    }

    @objc
    private func signInButtonTapped() {
        presenter.signInButtonDidTapped(loginTextField, passwordTextField)
    }
}

extension LoginViewController: LoginProtocol {
    public func setupTitle(_ title: String) {
        topLabel.text = title
    }

    public func setupTextFieldTitles(_ forLogin: String, _ forPassword: String) {
        loginTextField.title = forLogin
        loginTextField.placeholder = forLogin
        passwordTextField.title = forPassword
        passwordTextField.placeholder = forPassword
    }

    public func setupTextFieldErrors(_ forLogin: String?, _ forPassword: String?) {
        if let forLogin = forLogin {
            loginTextField.error = forLogin
        }
        if let forPassword = forPassword {
            passwordTextField.error = forPassword
        }
    }

    public func setupButtonTitle(_ title: String) {
        signInButton.setTitle(title, for: .normal)
    }

    public func setButtonEnabled(_ isEnabled: Bool) {
        signInButton.isEnabled = isEnabled
    }
}

extension UIViewController {
    func hideKeyboardOnBackgroundTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
