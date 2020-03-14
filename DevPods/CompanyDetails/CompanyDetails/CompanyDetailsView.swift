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

    public init() {
        UITableView.appearance().separatorStyle = .none
    }

    public var body: some View {
        VStack {
            List {
                Section {
                    CompanyCard(ticker: companyDetails.symbol, company: companyDetails.company)
                        .buttonStyle(PlainButtonStyle())
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: -24, trailing: 0))

                if companyDetails.articles.isEmpty {
                    HStack {
                        Spacer()
                        ActivityIndicator(isAnimating: .constant(true), style: .medium)
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
                } else {
                    Section {
                        Text("News")
                            .font(Font.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(Color(UIColor.blackText))
                            .padding(EdgeInsets(top: 40, leading: 16, bottom: 0, trailing: 0))
                        ForEach(companyDetails.articles) { (article: ArticleViewModel) in
                            ArticleRow(article: article)
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
    }

    func getData() {
        self.companyDetails.getCompany()
        self.companyDetails.getArticles()
    }
}

public class CompanyDetailsViewModel: ObservableObject {
    let symbol: String

    @Published var company: CompanyViewModel?
    var getCompanyTask: AnyCancellable?

    @Published var articles: [ArticleViewModel] = []
    var getArticlesTask: AnyCancellable?

    public init(symbol: String) {
        self.symbol = symbol
    }

    func getCompany() {
        getCompanyTask = nil
        getCompanyTask = CompanyApiService().combineFetchCompany(symbol: symbol).sink(receiveCompletion: { (completion) in
            print(completion)
        }, receiveValue: { (company) in
            self.company = CompanyViewModel(from: company)
        })
    }

    func getArticles() {
        getArticlesTask = nil
        getArticlesTask = CompanyApiService().combineFetchArticles(symbol: symbol).sink(receiveCompletion: { (completion) in
            print(completion)
        }, receiveValue: { (articles) in
            articles.forEach { (article) in
                self.articles.append(ArticleViewModel(from: article))
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyDetailsView()
    }
}
