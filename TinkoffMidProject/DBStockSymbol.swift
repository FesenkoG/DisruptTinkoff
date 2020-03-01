//
//  DBStockSymbol.swift
//  TinkoffMidProject
//
//  Created by a.gachkovskaya on 01.03.2020.
//  Copyright © 2020 TinkoffFintech. All rights reserved.
//

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

protocol DBInsertable: NSManagedObject {
    associatedtype DomainModel
    static var entityName: String { get }
    func toDomain() -> DomainModel
}

extension DBInsertable {
    static func insertOrUpdate(
        context: NSManagedObjectContext,
        updateWith: (Self) -> Void,
        predicate: NSPredicate
    ) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.predicate = predicate
        let object: Self
        if let result = try? context.fetch(request).first as? Self {
            object = result
        } else {
            object = Self(context: context)
        }
        updateWith(object)
    }
}
