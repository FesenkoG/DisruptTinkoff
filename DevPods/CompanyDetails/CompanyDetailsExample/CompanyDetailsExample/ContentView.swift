//
//  ContentView.swift
//  CompanyDetailsExample
//
//  Created by Artyom Kudryashov on 12.03.2020.
//

import SwiftUI
import TinkoffKit

struct CompanyDetailsView: View {

    var title: String = "Title"

    let company = CompanyViewModel.mock
    var articles = ArticleViewModel.mock

    init() {
        UITableView.appearance().separatorStyle = .none
    }

    var body: some View {
        VStack {
            List {

                Section {
                    CompanyCard(company: company)
                        .buttonStyle(PlainButtonStyle())
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: -24, trailing: 0))

                Section {
                    Text("News")
                        .font(Font.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(Color(UIColor.blackText))
                        .padding(EdgeInsets(top: 40, leading: 16, bottom: 0, trailing: 0))
                    ForEach(articles) { (article: ArticleViewModel) in
                        ArticleRow(article: article)
                    }
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyDetailsView()
    }
}
