//
//  CoreDataService.swift
//  TinkoffMidProject
//
//  Created by a.gachkovskaya on 01.03.2020.
//  Copyright © 2020 TinkoffFintech. All rights reserved.
//

import CoreData

final class CoreDataService {
    private lazy var container: NSPersistentContainer = {
        guard
            let url = Bundle(for: CoreDataService.self).url(
                forResource: "TinkoffMidProject",
                withExtension: "momd"
            ),
            let model = NSManagedObjectModel(contentsOf: url) else {
                fatalError("Wrong core data container configuration")
        }
        let container = NSPersistentContainer(
            name: "TinkoffMidProject",
            managedObjectModel: model
        )
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()

    var viewContext: NSManagedObjectContext {
        container.viewContext
    }

    func fetch<T: DBInsertable>(predicate: NSPredicate?) -> [T]? {
        var objects: [T]?
        viewContext.performAndWait {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName)
            request.predicate = predicate
            if let result = try? viewContext.fetch(request) as? [T] {
                objects = result
            }
        }
        return objects
    }

    func persist<T: DBInsertable>(
        updateWith: (T) -> Void,
        predicate: NSPredicate
    ) {
        viewContext.performAndWait {
            T.insertOrUpdate(
                context: viewContext,
                updateWith: updateWith,
                predicate: predicate
            )
        }
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
        }
    }
}
