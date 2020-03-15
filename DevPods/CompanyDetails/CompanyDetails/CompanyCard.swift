//
//  CompanyCard.swift
//  CompanyDetailsExample
//
//  Created by Artyom Kudryashov on 12.03.2020.
//

import SwiftUI
import TinkoffKit

extension AnyTransition {
    static var expandText: AnyTransition {
        return .asymmetric(insertion: .opacity, removal: .identity)
    }
    static var collapseText: AnyTransition {
        return .asymmetric(insertion: .identity, removal: .opacity)
    }
}

public struct CompanyCard: View {
    @State var ticker: String
    let company: CompanyViewModel?
    @Binding var error: String?
    var refreshAction: (() -> Void)

    @State private var isAboutExpanded: Bool = false

    public var body: some View {
        VStack(alignment: .leading) {

            HStack(alignment: .center, spacing: 8) {
                ZStack {
                    Rectangle()
                        .fill(CompanyViewModel.cardLinearGradient(for: ticker)).cornerRadius(12)
                        .shadow(color: CompanyViewModel.cardBottomColor(for: ticker), radius: 8, x: 0, y: 4)
                        .frame(width: 44, height: 44)

                    Text(ticker)
                        .font(Font.system(size: 25, weight: .bold, design: .rounded))
                        .foregroundColor(Color(UIColor.whiteText))
                        .lineLimit(1).minimumScaleFactor(0.3).padding(4)
                        .frame(width: 44, height: 44)
                }

                if company == nil {
                    if error == nil {
                        ActivityIndicator(isAnimating: .constant(true), style: .medium)
                            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
                    } else {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Couldn't load data")
                                .font(Font.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(Color(UIColor.blackText))
                            Button("Try again", action: refreshAction)
                                .font(Font.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(Color(UIColor.accentBlue))
                        }
                    }
                } else {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(company!.name)
                            .font(Font.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(Color(UIColor.blackText))
                        Text(company!.currency)
                            .font(Font.system(size: 12, weight: .medium, design: .rounded))
                            .foregroundColor(Color(UIColor.greyText))
                    }
                }

                Spacer()
            }

            if company != nil {
                if isAboutExpanded {
                    Text(company!.about)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .transition(.expandText)
                } else {
                    Text(company!.aboutShort)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .transition(.collapseText)
                }

                if company!.about.count > 180 {
                    Button(textForExpandButton(), action: toggleTextSize)
                        .font(Font.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(Color(UIColor.accentBlue))
                        .padding(EdgeInsets(top: 4, leading: 0, bottom: 16, trailing: 0))
                }
            }

            Spacer()
            Rectangle()
                .fill(Color(UIColor.borderGrey))
                .frame(height: 1)

        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
        .lineLimit(nil)
    }

    func toggleTextSize() {
        withAnimation(.easeInOut(duration: isAboutExpanded ? 0.1 : 0.33)) {
            isAboutExpanded.toggle()
        }
    }

    func textForExpandButton() -> String {
        return isAboutExpanded ? "Show less" : "Read more..."
    }
}

//struct CompanyCard_Previews: PreviewProvider {
//    static var previews: some View {
//        CompanyCard(ticker: "Test", company: CompanyViewModel.mock, error: ..., refreshAction: { print("refresh") })
//    }
//}

public struct CompanyViewModel {
    public let ticker: String
    public let name: String
    public let currency: String
    public let about: String

    init(ticker: String, name: String, currency: String, about: String) {
        self.ticker = ticker
        self.name = name
        self.currency = currency
        self.about = about
    }

    init(from dto: Company) {
        self.ticker = dto.ticker
        self.name = dto.name
        self.currency = dto.currency
        self.about = dto.description
    }

    static var mock: CompanyViewModel {
        CompanyViewModel(
            ticker: "AAPL",
            name: "Apple Inc.",
            currency: "USD",
            about: "Apple, Inc. engages in the design, manufacture, and sale of smartphones, personal computers, tablets, wearables and accessories, and other variety of related services. It operates through the following geographical segments: Americas, Europe, Greater China, Japan, and Rest of Asia Pacific. The Americas segment includes North and South America. The Europe segment consists of European countries, as well as India, the Middle East, and Africa. The Greater China segment comprises of China, Hong Kong, and Taiwan. The Rest of Asia Pacific segment includes Australia and Asian countries. Its products and services include iPhone, Mac, iPad, AirPods, Apple TV, Apple Watch, Beats products, Apple Care, iCloud, digital content stores, streaming, and licensing services. The company was founded by Steven Paul Jobs, Ronald Gerald Wayne, and Stephen G. Wozniak on April 1, 1976 and is headquartered in Cupertino, CA."
        )
    }

    var aboutShort: String {
        return about.prefix(180).trimmingCharacters(in: .whitespacesAndNewlines) + "..."
    }
}

extension CompanyViewModel {
    static func cardGradient(for ticker: String) -> Gradient {
        let uiColors = UIColor.gradient(for: ticker)
        return uiColors.count == 2
            ? Gradient(colors: [Color(uiColors[0]), Color(uiColors[1])])
            : Gradient(colors: [Color.red, Color.blue])
    }

    static func cardTopColor(for ticker: String) -> Color {
        if cardGradient(for: ticker).stops.count == 2  {
            return cardGradient(for: ticker).stops[0].color
        }
        return .red
    }

    static func cardBottomColor(for ticker: String) -> Color {
        if cardGradient(for: ticker).stops.count == 2  {
            return cardGradient(for: ticker).stops[1].color
        }
        return .red
    }

    static func cardLinearGradient(for ticker: String) -> LinearGradient {
        let (start, end) = (UnitPoint(x: 0.0, y: 0.0), UnitPoint(x: 0.0, y: 1.0))
        return LinearGradient(gradient: cardGradient(for: ticker), startPoint: start, endPoint: end)
    }
}
