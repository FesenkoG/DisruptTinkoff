//
//  ArticlesView.swift
//  CompanyDetails
//
//  Created by Georgy Fesenko on 3/15/20.
//

import Foundation
import SwiftUI

public struct ArticlesView: View {
    private let service = CompanyApiService()
    @EnvironmentObject var articlesViewModel: ArticlesViewModel

    public init() {}

    public var body: some View {
        List(articlesViewModel.articles) { article in
            ArticleRow(article: article)
        }
        .onAppear(perform: articlesViewModel.reloadArticles)
    }
}
