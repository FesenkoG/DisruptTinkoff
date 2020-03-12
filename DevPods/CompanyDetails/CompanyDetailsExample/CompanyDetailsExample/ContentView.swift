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

        if let largeTitleDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .headline)
            .withDesign(.rounded) {
            let font = UIFont(descriptor: largeTitleDescriptor, size: 34)
            UINavigationBar.appearance().largeTitleTextAttributes = [
                .font : font,
                .foregroundColor: UIColor.blackText
            ]
        }

        if let titleDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .headline)
            .withDesign(.rounded) {
            let font = UIFont(descriptor: titleDescriptor, size: 17)
            UINavigationBar.appearance().titleTextAttributes = [
                .font : font,
                .foregroundColor: UIColor.blackText
            ]
        }
    }

    var body: some View {
        NavigationView {

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
            .navigationBarTitle(
                Text(company.ticker)
                    .foregroundColor(Color(UIColor.blackText))
            )

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyDetailsView()
    }
}
