//
//  StockSymbolStorgeService.swift
//  TinkoffMidProject
//
//  Created by a.gachkovskaya on 01.03.2020.
//  Copyright © 2020 TinkoffFintech. All rights reserved.
//

import Storage

final class StockSymbolStorgeService {
    let storageService = StorageService(
        modelURL:
        Bundle.main.url(
            forResource: "TinkoffMidProject",
            withExtension: "momd"
        )!
    )

    func persist(stockSymbols: [StockSymbol]) {
        stockSymbols.forEach { symbol in
            storageService.persist(
                updateWith: { (dbSymbol: DBStockSymbol) in
                    dbSymbol.updateWithDomainModel(symbol)
                },
                predicate: NSPredicate(format: "symbol = %@", "\(symbol.symbol)")
            )
        }
    }

    func loadStockSymbols() -> [StockSymbol] {
        let symbols: [DBStockSymbol]? = self.storageService.fetch(predicate: nil)
        return symbols?.compactMap { $0.toDomain() } ?? []
    }
}
