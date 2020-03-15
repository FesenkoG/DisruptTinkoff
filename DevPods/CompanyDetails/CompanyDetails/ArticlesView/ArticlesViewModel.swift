//
//  ArticlesViewModel.swift
//  CompanyDetails
//
//  Created by Georgy Fesenko on 3/15/20.
//

import Foundation
import Combine

public class ArticlesViewModel: ObservableObject {
    @Published var articles: [ArticleViewModel] = []
    @Published var error: Error?
    @Published var articlesTask: AnyCancellable?

    private let companyApiService = CompanyApiService()

    public init() {}

    public func reloadArticles() {
        articlesTask = nil
        articlesTask = companyApiService.combineFetchArticles().sink(
            receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    self.error = error
                case .finished:
                    self.error = nil
                }
            }
        ) { articles in
            self.articles = articles.map(ArticleViewModel.init)
        }
    }
}
