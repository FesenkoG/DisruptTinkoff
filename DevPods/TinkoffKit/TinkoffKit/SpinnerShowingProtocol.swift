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
        indicatorView.startAnimating()
    }

    func hideSpinner() {
        indicatorView.stopAnimating()
    }
}
