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
        let vc = AuthLoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
