//
//  ArticlesView.swift
//  CompanyDetails
//
//  Created by Georgy Fesenko on 3/15/20.
//

import Foundation
import SwiftUI
import TinkoffKit

public struct TitleEnvironmentKey: EnvironmentKey {
    public typealias Value = String
    public static var defaultValue: String = "Title"
}

public extension EnvironmentValues {
    var title: String {
        get { self[TitleEnvironmentKey.self] }
        set { self[TitleEnvironmentKey.self] = newValue }
    }
}

public struct ArticlesView: View {
    private let service = CompanyApiService()
    @Environment(\.title) var title: String
    @EnvironmentObject var articlesViewModel: ArticlesViewModel

    @State private var highlightedArticleId: Int?
    @State var isSafariPresented: Bool = false
    @State var isSafariAlertPresenter: Bool = false
    @State var urlToOpen: URL? = nil


    public init() {
        UITableView.appearance().separatorStyle = .none
    }

    public var body: some View {
        VStack {
            List {

                Section {
                    ForEach(articlesViewModel.articles) { (article: ArticleViewModel) in
                        ArticleRow(article: article)
                            .scaleEffect(self.hightlightedScaleEffect(for: article.id))
                            .animation(self.animation(for: article.id))
                            .onTapGesture(perform: {
                                self.presentSafari(for: article.stringUrl)
                            })
                            .onLongPressGesture(minimumDuration: 0.7, maximumDistance: 0, pressing: { (hasTap) in
                                self.highlightedArticleId = hasTap ? article.id : nil
                            }) {
                                self.presentSafari(for: article.stringUrl)
                        }
                    }
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
        }
        .onAppear(perform: articlesViewModel.reloadArticles)
        .navigationBarTitle(
            Text(title)
        )
        .sheet(isPresented: $isSafariPresented) {
            SafariView(url: self.urlToOpen!)
        }
        .alert(isPresented: $isSafariAlertPresenter) {
            Alert(title: Text("Failed to open this news."))
        }
    }

    func presentSafari(for stringUrl: String) {
        if let url = URL(string: stringUrl) {
            urlToOpen = url
            isSafariPresented = true
        } else {
            isSafariAlertPresenter = true
        }
    }

    private func hightlightedScaleEffect(for articleId: Int) -> CGFloat {
        return articleId == highlightedArticleId ? 0.95 : 1
    }

    private func animation(for articleId: Int) -> Animation {
        return .easeInOut(duration: self.highlightedArticleId != nil ? 0.5 : 0.2)
    }
}
