//
//  ViewController.swift
//  CompanyDetailsExample
//
//  Created by Artyom Kudryashov on 12.03.2020.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        title = "Companies US"

        let button = UIButton(type: .system)
        button.setTitle("About AAPL", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate(
            [
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ]
        )
        button.addTarget(self, action: #selector(buttonDidTapped), for: .touchUpInside)
    }

    @objc func buttonDidTapped() {
        let detailsView = CompanyDetailsView()
        let hosting = UIHostingController(rootView: detailsView)
        navigationController?.pushViewController(hosting, animated: true)
    }
}
