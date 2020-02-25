//
//  AuthLoginViewController.swift
//  Authentication
//
//  Created by MacBook-Игорь on 24.02.2020.
//

import UIKit

public final class AuthLoginViewController: UIViewController {

    private lazy var presenter = AuthLoginPresenter(self)
    private var loginView: AuthLoginView!
    private var switchBox: UISwitchBox!
    private let isSmall = UIDevice.isSmall

    override public func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        loginView = AuthLoginView(frame: CGRect(x: 0, y: isSmall ? 50 : 200, width: view.frame.width, height: 230))
        loginView.delegate = self
        view.addSubview(loginView)

        switchBox = UISwitchBox(title: "Задать пин", onSwitchChange: { (_) in
            //TODO: -add action here
        })
        switchBox.frame = CGRect(x: 52,
                                 y: view.frame.height - 44 - CGFloat(isSmall ? 50 : 114),
                                 width: view.frame.width - 104,
                                 height: 44)
        view.addSubview(switchBox)
    }
}

extension AuthLoginViewController: AuthLoginPresenterProtocol {

}

extension AuthLoginViewController: AuthLoginViewDelegate {

}
