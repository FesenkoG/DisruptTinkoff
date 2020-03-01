//
//  UIViewController+Extension.swift
//  TinkoffKit
//
//  Created by Artyom Kudryashov on 01.03.2020.
//  Copyright © 2020 georgy. All rights reserved.
//

import UIKit

public protocol SpinnerShowingProtocol {
    var indicatorView: UIActivityIndicatorView { get set }
    func showSpinner()
    func hideSpinner()
}

public extension SpinnerShowingProtocol where Self: UIViewController {
    func showSpinner() {
        if indicatorView.superview == nil {
            view.addSubview(indicatorView)
            indicatorView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(
                [
                    indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                ]
            )
        }
        indicatorView.startAnimating()
    }

    func hideSpinner() {
        indicatorView.stopAnimating()
    }
}
