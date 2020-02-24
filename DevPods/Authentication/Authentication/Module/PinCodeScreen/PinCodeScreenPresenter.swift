//
//  PinCodeScreenPresenter.swift
//  Authentication
//
//  Created by Georgy Fesenko on 24/02/2020.
//

import Foundation

public protocol PinCodeScreenPresenterProtocol: class {
    func viewLoaded()

    func onPinCodeEntered(pinNumbers: [Int])
    func onActionButton()
}

public final class PinCodeScreenPresenter: PinCodeScreenPresenterProtocol {
    public struct UserCredentials {
        public let email: String

        public init(email: String) {
            self.email = email
        }
    }

    public weak var view: PinCodeScreenInput?

    private let keychainService: KeychainAuthenticationServiceProtocol
    private let userCredentials: UserCredentials
    private var enteredPinCode: [Int] = []

    public var completionHandler: ((Bool) -> Void)?

    public init(
        keychainService: KeychainAuthenticationServiceProtocol = KeychainAuthenticationService(),
        userCredentials: UserCredentials
    ) {
        self.keychainService = keychainService
        self.userCredentials = userCredentials
    }

    public func viewLoaded() {
        view?.setupSubtitle(userCredentials.email)
        if keychainService.isPinCodeExist {
            view?.setupTitle("Вход")
            view?.setupActionButtonTitle("Выйти из аккаунта")
        } else {
            view?.setupTitle("Новый пин-код")
            view?.setupActionButtonTitle("Отмена")
        }
    }

    public func onPinCodeEntered(pinNumbers: [Int]) {
        if keychainService.isPinCodeExist {
            completionHandler?(keychainService.validatePinCode(pinNumbers: pinNumbers))
        } else if enteredPinCode.isEmpty {
            enteredPinCode = pinNumbers
            view?.clearPinCode()
            view?.setupTitle("Подтвердить пин код")
            view?.setupActionButtonTitle("Назад")
        } else {
            guard enteredPinCode == pinNumbers else {
                return
            }
            completionHandler?(
                keychainService.storePinCode(pinNumbers: pinNumbers) == nil
            )
        }
    }

    public func onActionButton() {
        if enteredPinCode.isEmpty {
            completionHandler?(false)
        } else {
            enteredPinCode = []
            view?.setupTitle("Новый пин-код")
            view?.setupActionButtonTitle("Отмена")
        }
    }
}
