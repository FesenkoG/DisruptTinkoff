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

extension AuthLoginPresenter: AuthLoginViewDelegate {

    func validate(text: String?, inRange: NSRange, rString: String, type: Int) -> Bool {
        //TODO: -handle input from textFields
        //return true
        guard let nsString = text as NSString? else { return false }
        let newText = nsString.replacingCharacters(in: inRange, with: rString)
        if type == 0 {
            return newText.count <= 20
        } else {
            return newText.count <= 10
        }
    }
}
