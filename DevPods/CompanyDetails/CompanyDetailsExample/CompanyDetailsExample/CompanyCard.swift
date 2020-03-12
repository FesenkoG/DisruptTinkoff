//
//  CompanyCard.swift
//  CompanyDetailsExample
//
//  Created by Artyom Kudryashov on 12.03.2020.
//

import SwiftUI

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

struct CompanyCard_Previews: PreviewProvider {
    static var previews: some View {
        CompanyCard(company: CompanyViewModel.mock)
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
