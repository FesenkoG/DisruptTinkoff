//
//  ViewController.swift
//  TinkoffMidProject
//
//  Created by Georgy Fesenko on 19/02/2020.
//  Copyright © 2020 TinkoffFintech. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
hideKeyboardOnBackgroundTap()
        let ptf = PlainTextField(title: "titleeee")
        ptf.delegate = self
        view.addSubview(ptf)
        NSLayoutConstraint.activate(
            [
                ptf.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
                ptf.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
                ptf.widthAnchor.constraint(equalToConstant: 200)
            ]
        )
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "1234" {
            (textField as? PlainTextField)?.error = "errorr4g531"
        } else {
(textField as? PlainTextField)?.error = ""
        }
    }


}



extension UIViewController {
    func hideKeyboardOnBackgroundTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
