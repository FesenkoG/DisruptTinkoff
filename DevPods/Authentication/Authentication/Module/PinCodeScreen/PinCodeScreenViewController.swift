//
//  PinCodeScreenViewController.swift
//  Authentication
//
//  Created by Georgy Fesenko on 24/02/2020.
//

import UIKit

public protocol PinCodeScreenInput: class {
    func setupTitle(_ title: String)
    func setupSubtitle(_ subtitle: String)
    func setupActionButtonTitle(_ title: String)
    func clearPinCode()
}

public final class PinCodeScreenViewController: UIViewController {
    private let scrollView = UIScrollView()

    private let titleLable = UILabel()
    private let subtitleLabel = UILabel()
    private let pinCodeView = PinCodeView()
    private let actionButton = UIButton()

    private let presenter: PinCodeScreenPresenterProtocol

    public init(presenter: PinCodeScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        handleClosures()
        pinCodeView.becomeFirstResponder()
        presenter.viewLoaded()
    }

    private func setupUI() {
        [titleLable, subtitleLabel, scrollView, actionButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        scrollView.backgroundColor = .white
        view.addSubview(scrollView)

        titleLable.font = .systemFont(ofSize: 24.0, weight: .semibold)
        titleLable.textColor = .blackText
        scrollView.addSubview(titleLable)

        subtitleLabel.font = .systemFont(ofSize: 16.0, weight: .medium)
        subtitleLabel.textColor = .greyText
        scrollView.addSubview(subtitleLabel)

        scrollView.addSubview(pinCodeView)

        actionButton.titleLabel?.font = .systemFont(ofSize: 16.0)
        actionButton.setTitleColor(.accentBlue, for: .normal)
        scrollView.addSubview(actionButton)

        NSLayoutConstraint.activate(
            [
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

                titleLable.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 146),
                titleLable.leadingAnchor.constraint(greaterThanOrEqualTo: scrollView.leadingAnchor, constant: 16.0),
                titleLable.trailingAnchor.constraint(greaterThanOrEqualTo: scrollView.trailingAnchor, constant: 16.0),
                titleLable.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

                subtitleLabel.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 4.0),
                subtitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: scrollView.leadingAnchor, constant: 16.0),
                subtitleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: scrollView.trailingAnchor, constant: 16.0),
                subtitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

                pinCodeView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 24.0),
                pinCodeView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                pinCodeView.leadingAnchor.constraint(greaterThanOrEqualTo: scrollView.leadingAnchor, constant: 16.0),
                pinCodeView.trailingAnchor.constraint(greaterThanOrEqualTo: scrollView.trailingAnchor, constant: 16.0),

                actionButton.topAnchor.constraint(equalTo: pinCodeView.bottomAnchor, constant: 60),
                actionButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                actionButton.heightAnchor.constraint(equalToConstant: 32.0),
                actionButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 12)
            ]
        )
    }

    private func handleClosures() {
        pinCodeView.didEnterPin = { [weak presenter] pinNimbers in
            presenter?.onPinCodeEntered(pinNumbers: pinNimbers)
        }

        actionButton.addTarget(self, action: #selector(actionButtonTouchedUpInside), for: .touchUpInside)
    }

    @objc private func actionButtonTouchedUpInside() {
        presenter.onActionButton()
    }
}

extension PinCodeScreenViewController: PinCodeScreenInput {
    public func setupTitle(_ title: String) {
        titleLable.text = title
    }

    public func setupSubtitle(_ subtitle: String) {
        subtitleLabel.text = subtitle
    }

    public func setupActionButtonTitle(_ title: String) {
        actionButton.setTitle(title, for: .normal)
    }

    public func clearPinCode() {
        pinCodeView.clear()
        pinCodeView.becomeFirstResponder()
    }
}
