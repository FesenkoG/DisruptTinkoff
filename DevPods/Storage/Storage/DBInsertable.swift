//
//  DBInsertable.swift
//  Container
//
//  Created by a.gachkovskaya on 01.03.2020.
//  Copyright © 2020 a.gachkovskaya. All rights reserved.
//

import CoreData

public protocol DBInsertable: NSManagedObject {
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
