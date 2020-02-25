//
//  ViewController.swift
//  TinkoffMidProject
//
//  Created by Georgy Fesenko on 19/02/2020.
//  Copyright © 2020 TinkoffFintech. All rights reserved.
//

import UIKit
import Authentication

class ViewController: UIViewController {

    private let topLabel: UILabel = {
        let tl = UILabel()
        tl.text = "Путой экран"
        tl.font = UIFont.systemFont(ofSize: 24)
        return tl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let navigationController = navigationController else { return }
        let coordinator = AuthenticationCoordinator(navigationController: navigationController)
        coordinator.proceedWithAuthentication()
    }
}
