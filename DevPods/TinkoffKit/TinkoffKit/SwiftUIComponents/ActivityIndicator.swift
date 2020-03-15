//
//  ActivityIndicator.swift
//  CompanyDetails
//
//  Created by Artyom Kudryashov on 15.03.2020.
//

import SwiftUI
import SafariServices

public struct SafariView: UIViewControllerRepresentable {
    private let url: URL

    public init(url: URL) {
        self.url = url
    }

    public func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }

    public func updateUIViewController(_ safariViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) { }
}

public struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    public init(isAnimating: Binding<Bool>, style: UIActivityIndicatorView.Style) {
        self._isAnimating = isAnimating
        self.style = style
    }

    public func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: self.style)
    }

    public func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
