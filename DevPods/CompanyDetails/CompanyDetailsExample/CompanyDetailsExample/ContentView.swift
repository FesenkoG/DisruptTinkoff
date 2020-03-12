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
    var news = ArticleViewModel.mock

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
                    ForEach(news) { (article: ArticleViewModel) in
                        ArticleRow(article: article)
                    }
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))

            }
        }
    }
}

struct CompanyViewModel {
    let ticker: String
    let name: String
    let currency: String
    let about: String

    static var mock: CompanyViewModel {
        CompanyViewModel(
            ticker: "AAPL",
            name: "Apple Inc.",
            currency: "USD",
            about: "Apple, Inc. engages in the design, manufacture, and sale of smartphones, personal computers, tablets, wearables and accessories, and other variety of related services. It operates through the following geographical segments: Americas, Europe, Greater China, Japan, and Rest of Asia Pacific. The Americas segment includes North and South America. The Europe segment consists of European countries, as well as India, the Middle East, and Africa. The Greater China segment comprises of China, Hong Kong, and Taiwan. The Rest of Asia Pacific segment includes Australia and Asian countries. Its products and services include iPhone, Mac, iPad, AirPods, Apple TV, Apple Watch, Beats products, Apple Care, iCloud, digital content stores, streaming, and licensing services. The company was founded by Steven Paul Jobs, Ronald Gerald Wayne, and Stephen G. Wozniak on April 1, 1976 and is headquartered in Cupertino, CA."
        )
    }

    var cardGradient: Gradient {
        let uiColors = UIColor.gradient(for: ticker)
        return uiColors.count == 2
            ? Gradient(colors: [Color(uiColors[0]), Color(uiColors[1])])
            : Gradient(colors: [Color.red, Color.blue])
    }

    var cardTopColor: Color {
        if cardGradient.stops.count == 2  {
            return cardGradient.stops[0].color
        }
        return .red
    }

    var cardBottomColor: Color {
        if cardGradient.stops.count == 2  {
            return cardGradient.stops[1].color
        }
        return .red
    }

    var cardLinearGradient: LinearGradient {
        let (start, end) = (UnitPoint(x: 0.0, y: 0.0), UnitPoint(x: 0.0, y: 1.0))
        return LinearGradient(gradient: cardGradient, startPoint: start, endPoint: end)
    }
}

struct ArticleViewModel: Identifiable {

    let id: Int
    let title: String
    let source: String
    let date: String

    static var mock: [ArticleViewModel] {
        [
            ArticleViewModel(id: 0, title: "yewywger", source: "Hacker News", date: "Feb 31, 20:21"),
            ArticleViewModel(id: 1, title: "4j5ehrtymr", source: "Techcrunch", date: "Feb 22, 09:01"),
            ArticleViewModel(id: 2, title: "krtykrtymr", source: "The Guardian", date: "Feb 10, 12:44"),
            ArticleViewModel(id: 3, title: "h9-k0tymr", source: "Forbes", date: "Jan 28, 19:00"),
            ArticleViewModel(id: 4, title: "j4905inot", source: "SPSRT", date: "Jan 04, 02:59"),
        ]
    }

    var sourceColor: Color {
        let uiColor = UIColor.gradient(for: source).first?.withBrightness(0.66) ?? .blackText
        return Color(uiColor)
    }
}

struct ArticleRow: View {
    let article: ArticleViewModel

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(UIColor(hex: 0xf8f8f8))) // F8F8F8
                .cornerRadius(16)

            HStack() {
                Rectangle()
                    .fill(Color(UIColor.accentBlue))
                    .frame(width: 88, height: 88)
                    .cornerRadius(12)
                    .padding(8)

                VStack(alignment: .leading, spacing: 8) {
                    Text(article.title)
                        .font(Font.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundColor(Color(UIColor.blackText))
                        .lineLimit(3)
                    Text(article.date)
                        .font(Font.system(size: 10, weight: .regular, design: .rounded))
                        .foregroundColor(Color(UIColor.disabledText))
                }
                Spacer()
                Image(systemName: "plus")
                    .font(Font.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(Color(UIColor.disabledText))
                    .padding(12)

            }.overlay(
                Text(article.source)
                    .padding(6)
                    .font(Font.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundColor(article.sourceColor)
                    .background(Color(UIColor.commonGray))
                    .cornerRadius(8)
                .offset(x: -12, y: -12),
                alignment: .topTrailing
            )

        }.padding(12)
    }
}

struct CompanyCard: View {
    let company: CompanyViewModel

    var body: some View {
        VStack(alignment: .leading) {

            HStack(alignment: .center, spacing: 8) {
                ZStack {
                    Rectangle()
                        .fill(company.cardLinearGradient).cornerRadius(12)
                        .shadow(color: company.cardBottomColor, radius: 8, x: 0, y: 4)
                        .frame(width: 44, height: 44)

                    Text("A32APL")
                        .font(Font.system(size: 25, weight: .bold, design: .rounded))
                        .foregroundColor(Color(UIColor.whiteText))
                        .lineLimit(1).minimumScaleFactor(0.3).padding(4)
                    }
                VStack(alignment: .leading, spacing: 2) {
                    Text("Apple Inc")
                        .font(Font.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(Color(UIColor.blackText))
                    Text("USD")
                        .font(Font.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(Color(UIColor.greyText))
                }
                Spacer()
            }

            Text(company.about)
                .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0))
                .lineLimit(3)

            Button("Read more...", action: { print("gjeuwigjwegiw") })
                .font(Font.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(Color(UIColor.accentBlue))
                .padding(EdgeInsets(top: 4, leading: 0, bottom: 16, trailing: 0))

            Spacer()
            Rectangle()
                .fill(Color(UIColor.borderGrey))
                .frame(height: 1)

        }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyDetailsView()
    }
}
