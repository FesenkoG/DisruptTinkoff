//
//  AuthenticationCoordinator.swift
//  Authentication
//
//  Created by Georgy Fesenko on 25/02/2020.
//

import Foundation

public final class AuthenticationCoordinator {
    private weak var navigationController: UINavigationController?

    var completionHandler: (() -> Void)?

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func proceedWithAuthentication() {
        showLoginScreen()
    }

    private func showLoginScreen() {
        // TODO: - Show Login screen and either show pin screen or proceed without it if not requested
        showPinScreen(
            userCredentials: PinCodeScreenPresenter.UserCredentials.init(
                email: "feseneko.g@gmail.com"
            )
        )
    }

    private func showPinScreen(
        userCredentials: PinCodeScreenPresenter.UserCredentials
    ) {
        let pinScreenPresenter = PinCodeScreenPresenter(userCredentials: userCredentials)
        pinScreenPresenter.completionHandler = { isValidPinCodeEntered, isLoggedOut in
            guard !isLoggedOut else {
                self.onLoggedOut()
                return
            }

            self.onPinCodeEntered(success: isValidPinCodeEntered)
        }

        let pinCodeScreenViewController = PinCodeScreenViewController(presenter: pinScreenPresenter)
        navigationController?.present(
            pinCodeScreenViewController,
            animated: true,
            completion: nil
        )
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
