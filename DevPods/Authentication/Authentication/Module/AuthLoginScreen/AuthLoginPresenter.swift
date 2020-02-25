//
//  AuthLoginPresenter.swift
//  Authentication
//
//  Created by MacBook-Игорь on 24.02.2020.
//

import Foundation

protocol AuthLoginPresenterProtocol: class {

}

final class AuthLoginPresenter {

    private weak var viewController: AuthLoginPresenterProtocol?
    private var keychainManager = KeychainAuthenticationService()
    private var switchBoxIsOn: Bool = false

    init(_ viewController: AuthLoginPresenterProtocol) {
        self.viewController = viewController
    }

    func handleSwitchBoxToggle(isOn: Bool) {
        switchBoxIsOn = isOn
    }
}

extension AuthLoginPresenter: AuthLoginViewDelegate {

    func signIn(login: String?, password: String?) {

        guard let login = login, !login.isEmpty,
              let password = password, !password.isEmpty else { return }

        let isCredentialsValid = ValidationManager.validateEmail(email: login) &&
                                 ValidationManager.validatePassword(password: password)
        if isCredentialsValid {
            if switchBoxIsOn {
                //open pin code screen and pass credential
            } else {
                keychainManager.storeUserCredentials(email: login, password: password)
                //open mainScreen
            }
        } else {
            //show error
            return
        }
    }

    func validate(text: String?, inRange: NSRange, rString: String, type: Int) -> Bool {

        guard let nsString = text as NSString? else { return false }
        let newText = nsString.replacingCharacters(in: inRange, with: rString)
        if type == textFieldType.login {
            return newText.count <= loginMaxLength
        } else {
            return newText.count <= passwordMaxLength
        }
    }
}

private let loginMaxLength: Int = 20
private let passwordMaxLength: Int = 10
