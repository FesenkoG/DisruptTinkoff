//
//  Reusable.swift
//  TinkoffMidProject
//
//  Created by Georgy Fesenko on 2/29/20.
//  Copyright © 2020 TinkoffFintech. All rights reserved.
//

import UIKit

public protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

public extension UITableView {
    func dequeue<T: Reusable>(indexPath: IndexPath) -> T {
        //swiftlint:disable:next force_cast
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }

    func register<T: Reusable>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
}
