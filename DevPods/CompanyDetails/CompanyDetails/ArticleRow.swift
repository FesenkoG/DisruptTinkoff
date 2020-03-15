//
//  ArticleRow.swift
//  CompanyDetailsExample
//
//  Created by Artyom Kudryashov on 12.03.2020.
//

import SwiftUI

public struct ArticleRow: View {
    let article: ArticleViewModel

    public var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(UIColor.greyUnderlay))
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

struct ArticleRow_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRow(article: ArticleViewModel.mock.first!)
    }
}

public struct ArticleViewModel: Identifiable {

    public let id: Int
    public let title: String
    public let source: String
    public let date: String

    public static var mock: [ArticleViewModel] {
        [
            ArticleViewModel(id: 0, title: "Поведение слизевика оказалось неплохим методом выявления космической паутины", source: "Hacker News", date: "Feb 31, 20:21"),
            ArticleViewModel(id: 1, title: "Нервные и мышечные клетки ускорили развитие друг друга", source: "Techcrunch", date: "Feb 22, 09:01"),
            ArticleViewModel(id: 2, title: "Лена и Тамара из Винницы выцарапали свои имена на фреске Рафаэля", source: "The Guardian", date: "Feb 10, 12:44"),
            ArticleViewModel(id: 3, title: "Урок математики от американских журналистов: как поделить деньги Майка Блумберга и обсчитаться на всю страну", source: "Forbes", date: "Jan 28, 19:00"),
            ArticleViewModel(id: 4, title: "В Minecraft построили самолет из слизи и поршней. Летать он может, а вот приземляться и поворачивать — увы!", source: "SPSRT", date: "Jan 04, 02:59"),
            ArticleViewModel(id: 5, title: "В Minecraft построили самолет из слизи и поршней. Летать он может, а вот приземляться и поворачивать — увы!", source: "SPSRT", date: "Jan 04, 02:59"),
            ArticleViewModel(id: 6, title: "В Minecraft построили самолет из слизи и поршней. Летать он может, а вот приземляться и поворачивать — увы!", source: "SPSRT", date: "Jan 04, 02:59"),
        ]
    }

    var sourceColor: Color {
        let uiColor = UIColor.gradient(for: source).first?.withBrightness(0.66) ?? .blackText
        return Color(uiColor)
    }
}
