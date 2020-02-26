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
        if keychain.isPinCodeExist {
            showPinScreen(
                userCredentials: PinCodeScreenPresenter.UserCredentials.init(
                    email: "feseneko.g@gmail.com")
            )
        } else {
            let authLoginScreen = AuthLoginViewController()
            authLoginScreen.modalPresentationStyle = .fullScreen
            navigationController?.present(authLoginScreen, animated: true, completion: nil)
        }
    }

    func showPinScreen(
        userCredentials: PinCodeScreenPresenter.UserCredentials) {
        let pinScreenPresenter = PinCodeScreenPresenter(userCredentials: userCredentials)
        pinScreenPresenter.completionHandler = { completion in
            guard !completion.isLoggedOut else {
                self.onLoggedOut()
                return
            }

            self.onPinCodeEntered(success: completion.isValidPinCodeEntered)
        }

        let pinCodeScreenViewController = PinCodeScreenViewController(presenter: pinScreenPresenter)
        navigationController?.pushViewController(pinCodeScreenViewController, animated: true)
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
        // TODO: - Show login screen
    }
}
