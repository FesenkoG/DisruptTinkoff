//
//  DBStockSymbol.swift
//  TinkoffMidProject
//
//  Created by a.gachkovskaya on 01.03.2020.
//  Copyright © 2020 TinkoffFintech. All rights reserved.
//

import Storage
import CoreData

final class DBStockSymbol: NSManagedObject, DBInsertable {
    typealias DomainModel = StockSymbol
    static let entityName = "StockSymbol"

    @NSManaged var symbolDescription: String
    @NSManaged var displaySymbol: String
    @NSManaged var symbol: String

    func toDomain() -> StockSymbol {
        .init(description: symbolDescription, displaySymbol: displaySymbol, symbol: symbol)
    }

    func updateWithDomainModel(_ model: StockSymbol) {
        symbolDescription = model.description
        displaySymbol = model.displaySymbol
        symbol = model.symbol
    }
}
