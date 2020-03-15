//
//  ArticleRow.swift
//  CompanyDetailsExample
//
//  Created by Artyom Kudryashov on 12.03.2020.
//

import SwiftUI
import TinkoffKit
import struct Kingfisher.KFImage

public struct ArticleRow: View {
    let article: ArticleViewModel

    public var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(UIColor.greyUnderlay))
                .cornerRadius(16)

            HStack() {
                ZStack {
                    Rectangle()
                        .fill(article.sourceColorWithBrightness(of: 0.88))
                        .frame(width: 88, height: 88)
                        .cornerRadius(12)
                        .padding(8)
                    KFImage(URL(string: article.imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 88, height: 88)
                        .cornerRadius(12)
                        .padding(8)
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(UIColor.commonGray), lineWidth: 1)
                        .frame(width: 88, height: 88)
                }

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
                    .foregroundColor(article.sourceColorWithBrightness(of: 0.66))
                    .background(Color(UIColor.commonGray))
                    .cornerRadius(8)
                .offset(x: -12, y: -12),
                alignment: .topTrailing
            )

        }.padding(12)
    }
}

public struct ArticleViewModel: Identifiable {

    public let id: Int
    public let title: String
    public let source: String
    public let date: String
    public let stringUrl: String
    public let imageUrl: String

    init(from dto: Article) {
        id = dto.id
        title = dto.summary
        source = dto.source
        date = ArticleViewModel.formatDate(timestamp: dto.datetime)
        stringUrl = dto.url
        imageUrl = dto.image
    }

    init(id: Int, title: String, source: String, date: String, stringUrl: String) {
        self.id = id
        self.title = title
        self.source = source
        self.date = date
        self.stringUrl = stringUrl
        self.imageUrl = ""
    }

    public static var mock: [ArticleViewModel] {
        [
            ArticleViewModel(id: 0, title: "Поведение слизевика оказалось неплохим методом выявления космической паутины", source: "Hacker News", date: "Feb 31, 20:21", stringUrl: "https://www.notion.so/"),
            ArticleViewModel(id: 1, title: "Нервные и мышечные клетки ускорили развитие друг друга", source: "Techcrunch", date: "Feb 22, 09:01", stringUrl:  "https://tightype.com/shop/#plaid"),
            ArticleViewModel(id: 2, title: "Лена и Тамара из Винницы выцарапали свои имена на фреске Рафаэля", source: "The Guardian", date: "Feb 10, 12:44", stringUrl: "lgk9449h4h5"),
            ArticleViewModel(id: 3, title: "Урок математики от американских журналистов: как поделить деньги Майка Блумберга и обсчитаться на всю страну", source: "Forbes", date: "Jan 28, 19:00", stringUrl: "dqwdq"),
            ArticleViewModel(id: 4, title: "В Minecraft построили самолет из слизи и поршней. Летать он может, а вот приземляться и поворачивать — увы!", source: "SPSRT", date: "Jan 04, 02:59", stringUrl: "3h54j5j"),
            ArticleViewModel(id: 5, title: "В Minecraft построили самолет из слизи и поршней. Летать он может, а вот приземляться и поворачивать — увы!", source: "SPSRT", date: "Jan 04, 02:59", stringUrl: "175411"),
            ArticleViewModel(id: 6, title: "В Minecraft построили самолет из слизи и поршней. Летать он может, а вот приземляться и поворачивать — увы!", source: "SPSRT", date: "Jan 04, 02:59", stringUrl: "3h544424242j5j"),
        ]
    }

    func sourceColorWithBrightness(of value: CGFloat) -> Color {
        let uiColor = UIColor.gradient(for: source).first?.withBrightness(value) ?? .blackText
        return Color(uiColor)
    }

    static func formatDate(timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))

        let formatter = DateFormatter()
        formatter.dateFormat =
            Calendar.current.component(.year, from: date) == Calendar.current.component(.year, from: Date())
            ? "MMM d, HH:mm"
            : "yyyy, MMMM d"

        return formatter.string(from: date)
    }
}
