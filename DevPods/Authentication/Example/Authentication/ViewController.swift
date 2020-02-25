//
//  ViewController.swift
//  Authentication
//
//  Created by FesenkoG on 02/23/2020.
//  Copyright (c) 2020 FesenkoG. All rights reserved.
//

import UIKit
import Authentication

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let presenter = PinCodeScreenPresenter(userCredentials: .init(email: "fesenko.g@gmail.com"))
        let viewController = PinCodeScreenViewController(presenter: presenter)

        presenter.view = viewController

        present(viewController, animated: true, completion: nil)
    }
}
