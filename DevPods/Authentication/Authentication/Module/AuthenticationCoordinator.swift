//
//  AuthenticationCoordinator.swift
//  Authentication
//
//  Created by Georgy Fesenko on 25/02/2020.
//

import Foundation

public final class AuthenticationCoordinator {
    private weak var navigationController: UINavigationController?
    private let keychain = KeychainAuthenticationService()

    var completionHandler: (() -> Void)?

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func proceedWithAuthentication() {
        showLoginScreen()
    }

    private func showLoginScreen() {
        if keychain.isPinCodeExist, let email = keychain.getUserEmail() {
            showPinScreen(
                userCredentials: PinCodeScreenPresenter.UserCredentials.init(
                    email: email
                )
            )
        } else {
            let loginPresenter = LoginPresenter()
            let loginScreen = LoginViewController(presenter: loginPresenter)

            loginPresenter.completionHandler = { email, shouldEnterPin in
                self.navigationController?.presentedViewController?.dismiss(
                    animated: true,
                    completion: {
                       if shouldEnterPin {
                            self.showPinScreen(userCredentials: .init(email: email))
                        }
                    }
                )
            }
            loginScreen.modalPresentationStyle = .fullScreen
            navigationController?.present(loginScreen, animated: false)
        }
    }

    func showPinScreen(
        userCredentials: PinCodeScreenPresenter.UserCredentials
    ) {
        let pinScreenPresenter = PinCodeScreenPresenter(userCredentials: userCredentials)
        pinScreenPresenter.completionHandler = { completion in
            guard !completion.isLoggedOut else {
                self.onLoggedOut()
                return
            }

            self.onPinCodeEntered(success: completion.isValidPinCodeEntered)
        }

        let pinCodeScreenViewController = PinCodeScreenViewController(presenter: pinScreenPresenter)
        navigationController?.present(pinCodeScreenViewController, animated: true)
    }

    private func onPinCodeEntered(success: Bool) {
        guard success else { return }

        navigationController?.presentedViewController?.dismiss(
            animated: true,
            completion: {
                // TODO: - Show authorized user screen
            }
        )
    }

    private func onLoggedOut() {
        navigationController?.presentedViewController?.dismiss(
            animated: false,
            completion: {
                self.showLoginScreen()
            }
        )
    }
}
