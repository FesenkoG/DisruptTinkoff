//
//  PinCodeScreenPresenter.swift
//  Authentication
//
//  Created by Georgy Fesenko on 24/02/2020.
//

import Foundation

public protocol PinCodeScreenPresenterProtocol: AnyObject {
    var view: PinCodeScreenInputProtocol? { get set }

    func onPinCodeEnteredValidation(pinNumbers: [Int])

    func viewDidLoad()
    func onDismissButtonTouchedUpInside()
    func onActionButtonTouchedUpInside()

    func formDidReachedTransitionCenter()
}

public final class PinCodeScreenPresenter: PinCodeScreenPresenterProtocol {
    public struct UserCredentials {
        public let email: String

        public init(email: String) {
            self.email = email
        }
    }

    public struct PinCodeScreenCompletionResult {
        let isValidPinCodeEntered: Bool
        let isLoggedOut: Bool
    }

    public weak var view: PinCodeScreenInputProtocol?

    private let keychainService: KeychainAuthenticationServiceProtocol
    private let userCredentials: UserCredentials
    private var enteredPinCode: [Int] = []

    public var completionHandler: ((PinCodeScreenCompletionResult) -> Void)?

    public init(
        keychainService: KeychainAuthenticationServiceProtocol = KeychainAuthenticationService(),
        userCredentials: UserCredentials
    ) {
        self.keychainService = keychainService
        self.userCredentials = userCredentials
    }

    public func onPinCodeEnteredValidation(pinNumbers: [Int]) {
        if keychainService.isPinCodeExist {
            let isValidPinCode = keychainService.validatePinCode(pinNumbers: pinNumbers)
            completionHandler?(.init(isValidPinCodeEntered: isValidPinCode, isLoggedOut: false))

            if !isValidPinCode {
                view?.showPinError("Неверный пин")
            }
        } else if enteredPinCode.isEmpty {
            enteredPinCode = pinNumbers
            view?.blinkForm()
        } else {
            guard enteredPinCode == pinNumbers else {
                view?.showPinError("Неверный пин")
                return
            }
            completionHandler?(
                .init(
                    isValidPinCodeEntered: keychainService.storePinCode(pinNumbers: pinNumbers) == nil,
                    isLoggedOut: false
                )
            )
        }
    }
}

// MARK: - UI handling

extension PinCodeScreenPresenter {
    public func viewDidLoad() {
        view?.setupSubtitle(userCredentials.email)
        if keychainService.isPinCodeExist {
            view?.setupTitle("Вход")
            view?.setupButtonTitles(forDismiss: "Выйти из аккаунта", forAction: nil)
        } else {
            view?.setupTitle("Новый пин-код")
            view?.setupButtonTitles(forDismiss: "Отмена", forAction: nil)
        }
    }

    public func onDismissButtonTouchedUpInside() {
        if enteredPinCode.isEmpty {
            keychainService.clear()
            completionHandler?(.init(isValidPinCodeEntered: false, isLoggedOut: true))
        } else {
            enteredPinCode = []
            view?.blinkForm()
        }
    }

    public func onActionButtonTouchedUpInside() {
        if enteredPinCode.isEmpty {
            // actionButton doesn't exist here.
        } else {
            enteredPinCode = []
            completionHandler?(
                .init(
                    isValidPinCodeEntered: keychainService.validatePinCode(pinNumbers: enteredPinCode),
                    isLoggedOut: false
                )
            )
        }
    }

    public func formDidReachedTransitionCenter() {
        view?.clearPinCode()
        if !enteredPinCode.isEmpty {
            view?.setupTitle("Подтвердить пин-код")
            view?.setupButtonTitles(forDismiss: "Назад", forAction: "Войти")
        } else {
            view?.setupTitle("Новый пин-код")
            view?.setupButtonTitles(forDismiss: "Отмена", forAction: nil)
        }
    }
}
