//
//  StockSymbol.swift
//  TinkoffMidProject
//
//  Created by a.gachkovskaya on 01.03.2020.
//  Copyright © 2020 TinkoffFintech. All rights reserved.
//

import Foundation

struct StockSymbol: Decodable {
    let description: String
    let displaySymbol: String
    let symbol: String
}
