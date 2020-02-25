//
//  AuthLoginViewController.swift
//  Authentication
//
//  Created by MacBook-Игорь on 24.02.2020.
//

import UIKit

public final class AuthLoginViewController: UIViewController {

    private lazy var presenter = AuthLoginPresenter(self)
    private var loginView = AuthLoginView()
    private var switchBox: UISwitchBox!
    private let isSmallDevice = UIDevice.isSmall

    override public func viewDidLoad() {
        super.viewDidLoad()

        loginView.delegate = presenter

        switchBox = UISwitchBox(title: "Задать пин", onSwitchChange: { (isOn) in
            self.presenter.handleSwitchBoxToggle(isOn: isOn)
        })

        prepareUI()
    }

    private func prepareUI() {
        view.backgroundColor = .white
        view.addSubview(loginView)
        view.addSubview(switchBox)

        let switchBoxMinY = CGFloat(isSmallDevice ? 50 : 114) + 44
        NSLayoutConstraint.activate([

            loginView.topAnchor.constraint(equalTo: view.topAnchor,
                                           constant: isSmallDevice ? 50 : 200),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.heightAnchor.constraint(equalToConstant: 230),


            switchBox.topAnchor.constraint(equalTo: view.bottomAnchor,
                                           constant: -switchBoxMinY),
            switchBox.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: 52),
            switchBox.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                constant: -52)
        ])
    }
}

extension AuthLoginViewController: AuthLoginPresenterProtocol {

}

