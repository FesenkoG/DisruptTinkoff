//
//  PlainTextField.swift
//  TinkoffMidProject
//
//  Created by Artyom Kudryashov on 23.02.2020.
//  Copyright © 2020 TinkoffFintech. All rights reserved.
//

import UIKit
/**
You use PlainTextField as common UITextField, but use **title** instead of **placeholder**.

Minimum height implemented and it's **44px**. No need for setting heightAnchor for this.

 ## To show error state

    let ptf = PlainTextField(title: "Email", placeholder: "Type email")
    if condition {
        ptf.error = "Invalid email"
    }
*/
public final class PlainTextField: UITextField {
    // MARK: - Subviews

    private var borderView = UIView()
    private var titleView = UIView()
    private var titleLabel = UILabel()
    private var errorView = UIView()
    private var errorLabel = UILabel()

    // MARK: - PlainTextField Properties

    private let textFieldHeight: CGFloat = 44
    private let sideLabelsOffset: CGFloat = 12
    private let sideLabelsInset: CGFloat = 4
    private var titleFadeInDuration: TimeInterval = 0.4
    private var titleFadeOutDuration: TimeInterval = 0.4
    public var mainBackgroundColor = UIColor.white
    public var plainPlaceholderColor = UIColor.plainPlaceholder {
        didSet { updatePlaceholder() }
    }
    private var filledColor = UIColor.accentBlue {
        didSet { updateColors() }
    }
    private var selectedColor = UIColor.blackText {
        didSet { updateColors() }
    }
    private var initialColor = UIColor.borderGrey {
        didSet { updateColors() }
    }
    private var errorColor = UIColor.dangerRed {
        didSet { updateColors() }
    }
    private var placeholderFont = UIFont.systemFont(ofSize: 14) {
        didSet { updatePlaceholder() }
    }
    public var error: String = "" {
        didSet { updateControl(animated: true) }
    }
    public var title: String = "[Title]" {
        didSet { updateControl(animated: false) }
    }
    public override var textColor: UIColor? {
        didSet { updateControl(animated: false) }
    }
    public override var text: String? {
        didSet { updateControl(animated: false) }
    }
    public override var isSelected: Bool {
        didSet { updateControl(animated: true) }
    }
     private var hasError: Bool {
        return !error.isEmpty
    }
    public override var placeholder: String? {
        didSet {
            self.setNeedsDisplay()
            self.updatePlaceholder()
            self.updateTitleLabel()
        }
    }

    // MARK: - Init

    public init(title: String, placeholder: String? = nil) {
        super.init(frame: .zero)
        setup()
        self.title = title
        self.placeholder = placeholder ?? title
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

     private final func setup() {
        self.clearButtonMode = .never
        self.font = UIFont.systemFont(ofSize: 14)
        self.contentVerticalAlignment = .center

        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true

        setNeedsDisplay()

        createBorderView()
        createTitleLabel()
        createErrorLabel()

        updatePlaceholder()
        updateTitleLabel()

        updateColors()
        setNeedsDisplay()
        updatePlaceholder()
        updateTitleLabel()

        self.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }

    @objc func editingChanged() {
        updateControl(animated: true)
        updateTitleLabel(true)
    }

    // MARK: - Creating components

     private func createBorderView() {
        let view = UIView()

        view.backgroundColor = mainBackgroundColor
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = initialColor.cgColor
        view.isUserInteractionEnabled = false

        self.borderView = view
        self.addSubview(self.borderView)
    }

     private func createTitleLabel() {
        let view = UIView()
        view.backgroundColor = mainBackgroundColor
        view.isUserInteractionEnabled = false
        self.titleView = view
        self.addSubview(self.titleView)

        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.alpha = 0
        label.textColor = self.filledColor

        self.titleLabel = label
        self.addSubview(self.titleLabel)
    }

     private func createErrorLabel() {
        let view = UIView()
        view.backgroundColor = mainBackgroundColor
        view.isUserInteractionEnabled = false
        self.errorView = view
        self.addSubview(self.errorView)

        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.alpha = 0
        label.textColor = errorColor

        self.errorLabel = label
        self.addSubview(self.errorLabel)
    }

    // MARK: - Responder handling

    public override func becomeFirstResponder() -> Bool {
        self.updateControl(animated: true)
        return super.becomeFirstResponder()
    }

    public override func resignFirstResponder() -> Bool {
        self.updateControl(animated: true)
        return super.resignFirstResponder()
    }

    // MARK: - Updates

     private func updateControl(animated: Bool) {
        self.invalidateIntrinsicContentSize()
        self.updateColors()
        self.updateBorderView()
        self.updateTitleLabel(animated)
        self.updateErrorLabel(animated)
    }

    private func updateBorderView() {
        self.borderView.frame = self.borderViewRectForBounds(self.bounds)
        self.updateColors()
    }

    private func updatePlaceholder() {
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: plainPlaceholderColor, .font: self.placeholderFont]
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? self.title, attributes: attributes)
    }

    private func updateColors() {
        if self.hasError {
            self.borderView.layer.borderColor = self.errorColor.cgColor
            self.titleLabel.textColor = self.errorColor
            self.errorLabel.textColor = self.errorColor
        } else if isEditing {
            self.borderView.layer.borderColor = self.selectedColor.cgColor
            self.titleLabel.textColor = self.selectedColor
        } else if self.hasText {
            self.borderView.layer.borderColor = self.filledColor.cgColor
            self.titleLabel.textColor = self.filledColor
        } else {
            self.borderView.layer.borderColor = self.initialColor.cgColor
            self.titleLabel.textColor = self.initialColor
        }
        self.borderView.backgroundColor = mainBackgroundColor
        self.titleView.backgroundColor = mainBackgroundColor
        self.errorView.backgroundColor = mainBackgroundColor
    }

    // MARK: - Title & error handling

     private func updateTitleLabel(_ animated: Bool = false) {
        self.titleLabel.text = self.title
        self.updateTitleVisibility(animated)
    }

     private func updateErrorLabel(_ animated: Bool = false) {
        self.errorLabel.text = error
        self.updateErrorVisibility(animated)
    }

     private func setTitleVisible(_ titleVisible: Bool, animated: Bool = false) {
        self.updateColors()
        self.updateTitleVisibility(animated)
    }

     private func isTitleVisible() -> Bool { return self.hasText }

     private func isErrorVisible() -> Bool { return self.hasError }

     private func updateTitleVisibility(_ animated: Bool = false) {
        let alpha: CGFloat = isTitleVisible() ? 1.0 : 0.0

        self.titleView.frame = titleViewRectForBounds(self.bounds)
        self.titleLabel.frame = titleLabelRectForBounds(self.bounds)

        let updateLine = { self.titleView.alpha = alpha }
        let updateTitle = { self.titleLabel.alpha = alpha }

        if animated {
            let lineUpdating = {
                UIView.animate(
                    withDuration: 0.2,
                    delay: self.isTitleVisible() ? 0 : 0.05,
                    options: .curveEaseOut,
                    animations: { updateLine() }
                )
            }

            let titleUpdating = {
                UIView.animate(
                    withDuration: self.isTitleVisible() ? 0.2 : 0.1,
                    delay: self.isTitleVisible() ? 0.10 : 0,
                    options: .curveEaseOut,
                    animations: { updateTitle() }
                )
            }

            if isTitleVisible() {
                lineUpdating()
                titleUpdating()
            } else {
                titleUpdating()
                lineUpdating()
            }
        } else {
            updateLine()
            updateTitle()
        }
    }

     private func updateErrorVisibility(_ animated: Bool = false) {
        let alpha: CGFloat = isErrorVisible() ? 1.0 : 0.0

        self.errorView.frame = errorViewRectForBounds(self.bounds)
        self.errorLabel.frame = isErrorVisible() ? errorLabelRectForBounds(self.bounds) : .zero

        let updateLine = { self.errorView.alpha = alpha }
        let updateError = { self.errorLabel.alpha = alpha }

        if animated {
            let lineUpdating = {
                UIView.animate(
                    withDuration: 0.2,
                    delay: self.isErrorVisible() ? 0 : 0.05,
                    options: .curveEaseOut,
                    animations: { updateLine() }
                )
            }

            let errorUpdating = {
                UIView.animate(
                    withDuration: self.isErrorVisible() ? 0.2 : 0.1,
                    delay: self.isErrorVisible() ? 0.10 : 0,
                    options: .curveEaseOut,
                    animations: { updateError() }
                )
            }

            if isErrorVisible() {
                lineUpdating()
                errorUpdating()
            } else {
                errorUpdating()
                lineUpdating()
            }
        } else {
            updateLine()
            updateError()
        }
    }

    // MARK: - UITextField rect's

    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
            .inset(by: .init(top: 1, left: 16, bottom: 0, right: 16))
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

    // MARK: - Title & error view positioning

     private func titleLabelRectForBounds(_ bounds: CGRect) -> CGRect {
        let xOrigin: CGFloat = sideLabelsOffset + sideLabelsInset
        let yOrigin: CGFloat = -self.titleLabel.intrinsicContentSize.height / 2
        let width: CGFloat = self.titleLabel.intrinsicContentSize.width + sideLabelsInset * 2
        let height: CGFloat = self.titleLabel.intrinsicContentSize.height
        return CGRect(x: xOrigin, y: yOrigin, width: width, height: height)
    }

     private func titleViewRectForBounds(_ bounds: CGRect) -> CGRect {
        let xOrigin: CGFloat = sideLabelsOffset
        let yOrigin: CGFloat = 0
        let width: CGFloat = self.titleLabel.intrinsicContentSize.width + sideLabelsInset * 2
        let height: CGFloat = 1
        return CGRect(x: xOrigin, y: yOrigin, width: width, height: height)
    }

     private func errorLabelRectForBounds(_ bounds: CGRect) -> CGRect {
        guard !error.isEmpty else { return CGRect.zero }
        let xOrigin: CGFloat = sideLabelsOffset + sideLabelsInset
        let yOrigin: CGFloat = textFieldHeight - 1 - self.errorLabel.intrinsicContentSize.height / 2
        let width: CGFloat = self.errorLabel.intrinsicContentSize.width + sideLabelsInset * 2
        let height: CGFloat = self.errorLabel.intrinsicContentSize.height
        return CGRect(x: xOrigin, y: yOrigin, width: width, height: height)
    }

     private func errorViewRectForBounds(_ bounds: CGRect) -> CGRect {
        guard !error.isEmpty else { return CGRect.zero }
        let xOrigin: CGFloat = sideLabelsOffset
        let yOrigin: CGFloat = textFieldHeight - 1
        let width: CGFloat = self.errorLabel.intrinsicContentSize.width + sideLabelsInset * 2
        let height: CGFloat = 1
        return CGRect(x: xOrigin, y: yOrigin, width: width, height: height)
    }

     private func borderViewRectForBounds(_ bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
    }

     private func titleHeight() -> CGFloat {
        return self.titleLabel.font.lineHeight
    }

     private func textHeight() -> CGFloat {
        return self.font!.lineHeight
    }

     private func errorHeight() -> CGFloat {
        return self.errorLabel.font.lineHeight
    }

    // MARK: - Layout

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.invalidateIntrinsicContentSize()
        self.titleLabel.frame = self.titleLabelRectForBounds(self.bounds)
        self.errorLabel.frame = self.errorLabelRectForBounds(self.bounds)
        self.borderView.frame = self.borderViewRectForBounds(self.bounds)
    }
}
