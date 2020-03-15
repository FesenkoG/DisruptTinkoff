//
//  ArticlesView.swift
//  CompanyDetails
//
//  Created by Georgy Fesenko on 3/15/20.
//

import Foundation
import SwiftUI

public struct ArticlesView: View {
    var articles: [ArticleViewModel] = []

    public init(articles: [ArticleViewModel]) {
        self.articles = articles
    }
    
    public var body: some View {
        List(articles) { article in
            ArticleRow(article: article)
        }
    }
}

struct ArticlesView_Preview: PreviewProvider {
    static var previews: some View {
        ArticlesView(articles: ArticleViewModel.mock)
    }
}
