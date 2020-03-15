//
//  CompanyDetailsView.swift
//  CompanyDetailsExample
//
//  Created by Artyom Kudryashov on 12.03.2020.
//

import SwiftUI
import Combine
import TinkoffKit

public struct CompanyDetailsView: View {
    @EnvironmentObject var companyDetails: CompanyDetailsViewModel

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
                    CompanyCard(ticker: companyDetails.symbol, company: companyDetails.company, error: $companyDetails.companyError, refreshAction: getData)
                        .buttonStyle(PlainButtonStyle())
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))

                if companyDetails.articles == nil {
                    HStack {
                        Spacer()

                        if companyDetails.articlesError == nil {
                            ActivityIndicator(isAnimating: .constant(true), style: .medium)
                        } else {
                            VStack {
                                Text("Error occured while loading company details")
                                    .font(Font.system(size: 14, weight: .regular, design: .rounded))
                                    .foregroundColor(Color(UIColor.blackText))
                                Button("Try again", action: getData)
                                    .font(Font.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundColor(Color(UIColor.accentBlue))
                                    .padding(EdgeInsets(top: 4, leading: 0, bottom: 48, trailing: 0))
                                Text(companyDetails.articlesError!)
                                    .font(Font.system(size: 10, weight: .light, design: .rounded))
                                    .foregroundColor(Color(UIColor.disabledText))
                            }
                        }

                        Spacer()
                    }
                    .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
                    .buttonStyle(PlainButtonStyle())
                } else {
                    Section {
                        Text("News")
                            .font(Font.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(Color(UIColor.blackText))
                            .padding(EdgeInsets(top: 40, leading: 16, bottom: 0, trailing: 0))
                        if companyDetails.articles!.isEmpty {
                            Text("No news for this company")
                                .font(Font.system(size: 14, weight: .light, design: .rounded))
                                .foregroundColor(Color(UIColor.disabledText))
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
                        } else {
                            ForEach(companyDetails.articles!) { (article: ArticleViewModel) in
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
                    }
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            }

        }
        .onAppear(perform: getData)
        .navigationBarTitle(
            Text(companyDetails.symbol)
        )
        .sheet(isPresented: $isSafariPresented) {
            SafariView(url: self.urlToOpen!)
        }
        .alert(isPresented: $isSafariAlertPresenter) {
            Alert(title: Text("Failed to open this news."))
        }
    }

    func getData() {
        if companyDetails.company == nil {
            companyDetails.getCompany {
                self.companyDetails.getArticles()
            }
        } else if companyDetails.articles == nil {
            companyDetails.getArticles()
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

public class CompanyDetailsViewModel: ObservableObject {
    let symbol: String

    @Published var company: CompanyViewModel?
    @Published var companyTask: AnyCancellable?
    @Published var companyError: String?

    @Published var articles: [ArticleViewModel]?
    @Published var articlesTask: AnyCancellable?
    @Published var articlesError: String?

    public init(symbol: String) {
        self.symbol = symbol
    }

    func getCompany(completion: (() -> Void)?) {
        companyTask = nil
        companyError = nil
        companyTask = CompanyApiService().combineFetchCompany(symbol: symbol).sink(receiveCompletion: { (receiveCompletion) in
            switch receiveCompletion {
            case .failure(let error):
                self.companyError = error.localizedDescription
            case .finished:
                self.companyError = nil
            }
            completion?()
        }, receiveValue: { (company) in
            self.company = CompanyViewModel(from: company)
        })
    }

    func getArticles() {
        articlesTask = nil
        articlesError = nil
        articlesTask = CompanyApiService().combineFetchArticles(symbol: symbol).sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure(let error):
                self.articlesError = error.localizedDescription
            case .finished:
                self.articlesError = nil
            }
        }, receiveValue: { (articles) in
            self.articles = [ArticleViewModel]()
            articles.forEach { (article) in
                self.articles!.append(ArticleViewModel(from: article))
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyDetailsView()
    }
}
