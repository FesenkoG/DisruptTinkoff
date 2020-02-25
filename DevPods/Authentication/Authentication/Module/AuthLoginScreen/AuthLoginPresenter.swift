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

    init(_ viewController: AuthLoginPresenterProtocol) {
        self.viewController = viewController
    }
}
