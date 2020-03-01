//
//  StockExchange.swift
//  TinkoffMidProject
//
//  Created by a.gachkovskaya on 01.03.2020.
//  Copyright © 2020 TinkoffFintech. All rights reserved.
//

import Foundation

typealias ExchangeCode = String

struct StockExchange: Decodable {
    let code: ExchangeCode
    let currency: String
    let name: String
}
