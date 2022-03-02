//
//  BaseStorageProtocols.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 16/02/2022.
//

import Foundation

/// Query options
public struct Sorted {

    /// sort by key
    var key: String

    /// sort direction
    var ascending: Bool = true

}
/// Operations for readable storage
protocol BaseReadableStorage {
    /// Return a list of objects that are conformed to the `Storable` protocol
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: (([T]) -> Void))
}

/// Operations for writeable storage
protocol BaseWriteableStorage {
    /*!
     * Create a new object with default values
     * - return: an object that is conformed to the `Storable` protocol
     */
    func create<T: Storable>(_ model: T.Type , updates: Any?, completion: @escaping ((T) -> Void)) throws

    /// Save an object that is conformed to the `Storable` protocol
    func save(object: Storable) throws
    /// Save a list that is conformed to the `Storable` protocol
    /// - Parameter list: list of elements
    func save(list: [Storable]) throws
    /// Update an object that is conformed to the `Storable` protocol
    func update(block: @escaping () -> Void) throws
    /// Delete an object that is conformed to the `Storable` protocol
    func delete(object: Storable) throws
    /// Delete a list of objects that is conformed to the `Storable` protocol
    func delete(list: [Storable]) throws
    /// Delete all objects that are conformed to the `Storable` protocol
    func truncate<T: Storable>(_ model: T.Type) throws
}

/// Operations on context
protocol BaseStorageContext: BaseReadableStorage & BaseWriteableStorage { }

public protocol Storable { }
