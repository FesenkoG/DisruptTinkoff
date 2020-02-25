//
//  PinCodeScreenViewController.swift
//  Authentication
//
//  Created by Georgy Fesenko on 24/02/2020.
//

import UIKit

public protocol PinCodeScreenInputProtocol: class {
    func setupTitle(_ title: String)
    func setupSubtitle(_ subtitle: String)
    func setupButtonTitles(forDismiss: String?, forAction: String?)
    func clearPinCode()
    func blinkForm()
}

private let defaultLeadingTrailingSpacing: CGFloat = 16.0

public final class PinCodeScreenViewController: UIViewController {
    private let scrollView = UIScrollView()

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let pinCodeView = PinCodeView()
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 24
        return stackView
    }()
    private let dismissButton = UIButton(type: .system)
    private let actionButton = UIButton(type: .system)

    private let presenter: PinCodeScreenPresenterProtocol

    public init(presenter: PinCodeScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        presenter.view = self
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
        presenter.viewDidLoad()
    }

    private func setupUI() {
        view.backgroundColor = .white

        [titleLabel, subtitleLabel, scrollView, buttonsStackView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        scrollView.backgroundColor = .white
        view.addSubview(scrollView)

        titleLabel.font = .systemFont(ofSize: 24.0, weight: .semibold)
        titleLabel.textColor = .blackText
        scrollView.addSubview(titleLabel)

        subtitleLabel.font = .systemFont(ofSize: 16.0, weight: .medium)
        subtitleLabel.textColor = .greyText
        scrollView.addSubview(subtitleLabel)

        scrollView.addSubview(pinCodeView)

        buttonsStackView.addArrangedSubview(dismissButton)
        buttonsStackView.addArrangedSubview(actionButton)
        scrollView.addSubview(buttonsStackView)

        NSLayoutConstraint.activate(
            [
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

                titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 146),
                titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: scrollView.leadingAnchor, constant: defaultLeadingTrailingSpacing),
                titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: scrollView.trailingAnchor, constant: defaultLeadingTrailingSpacing),
                titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

                subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.0),
                subtitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: scrollView.leadingAnchor, constant: defaultLeadingTrailingSpacing),
                subtitleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: scrollView.trailingAnchor, constant: defaultLeadingTrailingSpacing),
                subtitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

                pinCodeView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 24.0),
                pinCodeView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                pinCodeView.leadingAnchor.constraint(greaterThanOrEqualTo: scrollView.leadingAnchor, constant: defaultLeadingTrailingSpacing),
                pinCodeView.trailingAnchor.constraint(greaterThanOrEqualTo: scrollView.trailingAnchor, constant: defaultLeadingTrailingSpacing),

                buttonsStackView.topAnchor.constraint(equalTo: pinCodeView.bottomAnchor, constant: 60),
                buttonsStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                buttonsStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 12)
            ]
        )
    }

    private func handleClosures() {
        pinCodeView.didEnterPin = { [weak self] pinNumbers in
            guard self?.presenter.onPinCodeEnteredValidation(pinNumbers: pinNumbers) ?? false else {
                self?.pinCodeView.setErrorUI()
                self?.showInvalidPincodeAlert()
                return
            }

            self?.blinkForm()
        }

        dismissButton.addTarget(self, action: #selector(dismissButtonTouchedUpInside), for: .touchUpInside)
        actionButton.addTarget(self, action: #selector(actionButtonTouchedUpInside), for: .touchUpInside)
    }

    @objc private func dismissButtonTouchedUpInside() {
        presenter.onDismissButton()
    }

    @objc private func actionButtonTouchedUpInside() {
        presenter.onActionButton()
    }
}

extension PinCodeScreenViewController: PinCodeScreenInputProtocol {
    public func setupTitle(_ title: String) {
        titleLabel.text = title
    }

    public func setupSubtitle(_ subtitle: String) {
        subtitleLabel.text = subtitle
    }

    public func setupButtonTitles(forDismiss dismissTitle: String?, forAction actionTitle: String?) {
        dismissButton.setTitle(dismissTitle, for: .normal)
        actionButton.setTitle(actionTitle, for: .normal)
        dismissButton.isHidden = dismissTitle == nil
        actionButton.isHidden = actionTitle == nil
    }

    public func clearPinCode() {
        pinCodeView.clear()
        pinCodeView.becomeFirstResponder()
    }

    public func blinkForm() {
        DispatchQueue.main.async { [weak presenter] in presenter?.formDidBeginTransitioning()

            UIView.animate(withDuration: 0.22, animations: { [weak self] in
                self?.scrollView.alpha = 0
            }) { [weak presenter] (_) in presenter?.formDidReachedTransitionCenter()

                UIView.animate(withDuration: 0.22, animations:  { [weak self] in
                    self?.scrollView.alpha = 1
                }) { [weak presenter] (_) in presenter?.formDidEndTransitioning() }
            }
        }
    }
}

extension PinCodeScreenViewController {
    private func showInvalidPincodeAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Вы ввели неправильный пин.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Понятно", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
