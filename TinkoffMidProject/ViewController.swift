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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let navigationController = navigationController else { return }
        let coordinator = AuthenticationCoordinator(navigationController: navigationController)
        coordinator.proceedWithAuthentication()
    }
}
