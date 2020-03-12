//
//  ContentView.swift
//  CompanyDetailsExample
//
//  Created by Artyom Kudryashov on 12.03.2020.
//

import SwiftUI

struct CompanyDetailsView: View {

    var title: String = "Title"

    var news = News.mock

    init() {
        UITableView.appearance().separatorStyle = .none
    }

    var body: some View {
        VStack {
            List {

                Section {
                    StockCard().buttonStyle(PlainButtonStyle())
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: -24, trailing: 0))

                Section {
                    Text("News")
                        .font(Font.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(Color(white: 0.2, opacity: 1)) // 333333
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
                    ForEach(news) { (n: News) in
                        NewsRow(news: n)
                    }
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))

            }
        }
    }
}

struct News: Identifiable {

    let id: Int
    let title: String

    static var mock: [News] {
        [
            News(id: 0, title: "yewywger"),
            News(id: 1, title: "4j5ehrtymr"),
            News(id: 2, title: "krtykrtymr"),
            News(id: 3, title: "h9-k0tymr"),
            News(id: 4, title: "j4905inot"),
        ]
    }
}

struct NewsRow: View {
    let news: News

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(white: 0.96, opacity: 1)) // F8F8F8
                .cornerRadius(16)

            HStack() {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 88, height: 88)
                    .cornerRadius(12)
                    .padding(8)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Logitech Launches New POWERED 3-in-1 Dock for Wirelessly Charging iPhone, AirPods and Apple Watch...")
                        .font(Font.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundColor(Color(white: 0.2, opacity: 1)) // 333333
                        .lineLimit(3)
                    Text("Feb 30, 20:21")
                        .font(Font.system(size: 10, weight: .regular, design: .rounded))
                        .foregroundColor(Color(white: 170/255, opacity: 1)) // AAAAAA
                }
                Image(systemName: "plus")
                    .font(Font.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(Color(white: 170/255, opacity: 1)) // AAAAAA

            }.overlay(
                Text("123")
                    .padding(6)
                    .font(Font.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundColor(Color(white: 240/255, opacity: 1)) // F0F0F0
                    .background(Color.blue)
                    .cornerRadius(8)
                .offset(x: -12, y: -12),
                alignment: .topTrailing
            )

        }.padding(12)
    }
}

var lim = 3

struct StockCard: View {
    var cardText = "Apple Inc. designs, manufactures and markets mobile communication and media devices, personal computers and portable digital music players. The Company sells a range of related sof... Apple Inc. designs, manufactures and markets mobile communication and media devices, personal computers and portable digital music players. The Company sells a range of related sof..."

    var body: some View {
        VStack(alignment: .leading) {

            HStack(alignment: .center, spacing: 8) {
                ZStack {
                    Rectangle()
                        .fill(Color.blue).cornerRadius(12)
                        .shadow(color: Color.blue, radius: 8, x: 0, y: 4)
                        .frame(width: 44, height: 44)
                    Text("A32APL")
                        .font(Font.system(size: 25, weight: .bold, design: .rounded))
                        .foregroundColor(Color.white)
                        .lineLimit(1).minimumScaleFactor(0.3).padding(4)
                    }
                VStack(alignment: .leading, spacing: 2) {
                    Text("Apple Inc")
                        .font(Font.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(Color(white: 0.2, opacity: 1)) // 333333
                    Text("USD")
                        .font(Font.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(Color(white: 0.2, opacity: 1)) // 333333
                }
                Spacer()
            }

            Text(cardText)
                .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0))
                .lineLimit(3)

            Button("Read more...", action: { print("gjeuwigjwegiw") })
                .font(Font.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(Color.init(red: 82/255, green: 139/255, blue: 255/255)) // 528BFF
                .padding(EdgeInsets(top: 4, leading: 0, bottom: 16, trailing: 0))

            Spacer()
            Rectangle()
                .fill(Color.init(red: 236/255, green: 236/255, blue: 236/255))
                .frame(height: 1)

        }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyDetailsView()
    }
}
