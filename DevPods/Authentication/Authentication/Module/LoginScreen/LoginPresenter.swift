//
//  AuthLoginViewController.swift
//  Authentication
//
//  Created by Artyom Kudryashov on 26.02.2020.
//  Copyright © 2020 TinkoffFintech. All rights reserved.
//

import UIKit

public protocol LoginPresenterProtocol: AnyObject {
    var view: LoginProtocol? { get set }

    func viewDidLoad()
    func editingDidEnd(_ loginTextField: PlainTextField, _ passwordTextField: PlainTextField, editedTextField: LoginViewController.TypOfTextField)
    func editingChanged(_ loginTextField: PlainTextField, _ passwordTextField: PlainTextField, editedTextField: LoginViewController.TypOfTextField)
    func signInButtonDidTapped(_ loginTextField: PlainTextField, _ passwordTextField: PlainTextField)
    func onPinSwitchChange(_ isOn: Bool)
}

public final class LoginPresenter: LoginPresenterProtocol {
    public weak var view: LoginProtocol?
    private var isPinEnabled: Bool = false

    public var completionHandler: ((_ email: String, _ shouldEnterPin: Bool) -> Void)?

    public init() { }

    public func viewDidLoad() {
        view?.setupTitle("Вход")
        view?.setupTextFieldTitles("Почта", "Пароль")
        view?.setupButtonTitle("Войти")
    }
}

extension LoginPresenter {
    public func onPinSwitchChange(_ isOn: Bool) {
        isPinEnabled = isOn
        print(isPinEnabled)
    }

    public func editingDidEnd(
        _ loginTextField: PlainTextField,
        _ passwordTextField: PlainTextField,
        editedTextField: LoginViewController.TypOfTextField
    ) {
        validateEmailTextField(loginTextField)
        validatePasswordTextField(passwordTextField)

        view?.setButtonEnabled(isValidEmail(loginTextField.text) && isValidPassword(passwordTextField.text))
    }

    public func editingChanged(
        _ loginTextField: PlainTextField,
        _ passwordTextField: PlainTextField,
        editedTextField: LoginViewController.TypOfTextField
    ) {
        view?.setButtonEnabled(isValidEmail(loginTextField.text) && isValidPassword(passwordTextField.text))
    }

    public func signInButtonDidTapped(_ loginTextField: PlainTextField, _ passwordTextField: PlainTextField) {
        guard
            isValidEmail(loginTextField.text) && isValidPassword(passwordTextField.text)
        else {
            validateEmailTextField(loginTextField, errorForEmpty: true)
            validatePasswordTextField(passwordTextField, errorForEmpty: true)
            return
        }

        let email = loginTextField.text ?? ""
        completionHandler?(email, isPinEnabled)
    }
}

extension LoginPresenter {
    private func validateEmailTextField(_ ptf: PlainTextField, errorForEmpty: Bool = false) {
        if let email = ptf.text, !isValidEmail(email) {
            if email.isEmpty {
                if errorForEmpty {
                    view?.setupTextFieldErrors("Почта не может быть пустой", nil)
                } else {
                    view?.setupTextFieldErrors("", nil)
                }
            } else {
                view?.setupTextFieldErrors("Неправильная почта", nil)
            }
        } else {
            view?.setupTextFieldErrors("", nil)
        }
    }

    private func validatePasswordTextField(_ ptf: PlainTextField, errorForEmpty: Bool = false) {
        if let password = ptf.text, !isValidPassword(password) {
            if password.isEmpty {
                if errorForEmpty {
                    view?.setupTextFieldErrors(nil, "Пароль не может быть пустым")
                } else {
                    view?.setupTextFieldErrors(nil, "")
                }
            } else {
                view?.setupTextFieldErrors(nil, "Пароль должен быть от 6 символов")
            }
        } else {
            view?.setupTextFieldErrors(nil, "")
        }
    }

    private func isValidEmail(_ email: String?) -> Bool {
        guard let email = email else { return false }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    private func isValidPassword(_ password: String?) -> Bool {
        guard let password = password else { return false }
        return password.count >= 6
    }
}
