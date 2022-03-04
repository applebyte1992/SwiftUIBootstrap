//
//  DBManager.swift
//  Muslim360
//
//  Created by Masroor Elahi on 2/7/19.
//  Copyright © 2019 TEO International. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

extension Object: Storable { }

enum RealmError: Error {
    case eitherRealmIsNilOrNotRealmSpecificModel
    case realmException(String)
}

extension RealmError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .eitherRealmIsNilOrNotRealmSpecificModel:
            return "Realm not found"
        case .realmException(let error):
            return error
        }
    }
    var asAppError: AppError {
        return AppError.buildDatabaseError(databaseError: self)
    }
}

class RealmContextManager: BaseStorageContext {
    /// Clear all data from realm
    static func clearRealmDB() {
        let realm = try? Realm()
        realm?.beginWrite()
        realm?.deleteAll()
        try? realm?.commitWrite()
    }
    /// Prepare realm with configurations and migration block
    static func prepareDefaultRealm() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { _, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                }
            })
        Realm.Configuration.defaultConfiguration = config
        tryRealmObject()
    }
    /// Fallback for realm - Incase realm fails to initialize due to any reason. Remove realm file and start again
    static func tryRealmObject() {
        do {
            _ = try Realm()
        } catch let error {
            print(error.localizedDescription)
            if let realmFile = Realm.Configuration.defaultConfiguration.fileURL {
                try? FileManager.default.removeItem(at: realmFile)
            }
        }
    }
    private var realm: Realm?
    /// Initialize Realm
    /// - Parameter realm: Realm Object
    init(realm: Realm? = try? Realm()) {
        self.realm = realm
    }
    func save(object: Storable) throws {
        guard let realm = self.realm else {
            throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel
        }
        guard let object = object as? Object else {
            return
        }
        do {
            try realm.write {
                realm.add(object)
            }
        } catch let excep {
            throw RealmError.realmException(excep.localizedDescription).asAppError
        }
#if DEBUG
        print(realm.configuration.fileURL ?? "")
#endif
    }
    func update(block: @escaping () -> Void ) throws {
        guard let realm = self.realm else {
            throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel
        }
#if DEBUG
        print(realm.configuration.fileURL ?? "")
#endif
        do {
            try realm.write {
                block()
            }
        } catch let excep {
            throw RealmError.realmException(excep.localizedDescription).asAppError
        }
    }
    func delete(object: Storable) throws {
        guard let realm = self.realm else {
            throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel
        }
        guard let object = object as? Object else {
            return
        }
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch let excep {
            throw RealmError.realmException(excep.localizedDescription).asAppError
        }
    }
    func truncate<T>(_ model: T.Type) throws where T: Storable {
        guard let realm = self.realm else {
            throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel
        }
        do {
            try realm.write {
                guard let castType = model as? Object.Type else {
                    return
                }
                let allNotifications = realm.objects(castType)
                realm.delete(allNotifications)
            }
        } catch let excep {
            throw RealmError.realmException(excep.localizedDescription).asAppError
        }
    }
    func fetch<T>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: (([T]) -> Void)) where T: Storable {
        do {
            guard let realm = self.realm else {
                throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel
            }
            guard let castType = model as? Object.Type else {
                return
            }
            var result: Results<Object>
            if let predicate = predicate {
                result = realm.objects(castType).filter(predicate)
            } else {
                result = realm.objects(castType)
            }
            let typeArray: [T] = result.toArray(type: model)
            completion(typeArray)
        } catch let excep {
            print(excep.localizedDescription)
        }
    }
    
    
    func save(list: [Storable]) throws {
        guard let realm = self.realm else {
            throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel
        }
        let mappedList = list.compactMap({$0 as? Object})
        do {
            try realm.write {
                realm.add(mappedList,update: .all)
            }
        } catch let excep {
            throw RealmError.realmException(excep.localizedDescription).asAppError
        }
#if DEBUG
        print(realm.configuration.fileURL ?? "")
#endif
    }
    func delete(list: [Storable]) throws {
        guard let realm = self.realm else {
            throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel
        }
        let mappedList = list.compactMap({$0 as? Object})
        do {
            try realm.write {
                realm.delete(mappedList)
            }
        } catch let excep {
            throw RealmError.realmException(excep.localizedDescription).asAppError
        }
#if DEBUG
        print(realm.configuration.fileURL ?? "")
#endif
    }
    func create<T>(_ model: T.Type, updates: Any?, completion: @escaping ((T) -> Void)) throws where T: Storable {
    }
}

extension Results {
    /// Convert Realm Arrat To Swift Array
    /// - Parameter type: Realm Array
    /// - Returns: Swift Array
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}

extension List {
    /// Convert Realm List to Swift Array
    /// - Parameter type: Realm List Type
    /// - Returns: Swift Array with mentioned type
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}

extension Array {
    /// Convert Swift Array to Realm List
    /// - Parameter type: Swift List Type
    /// - Returns: Realm List with type
    func toRealmList<T: Object>(type: T.Type) -> List<T> {
        let list = List<T>()
        let value = compactMap({$0 as? T})
        list.append(objectsIn: value)
        return list
    }
}

// Uncomment this for clone
protocol DetachableObject: AnyObject {
    /// Clone of Realm Object
    func detached() -> Self
}

extension Object: DetachableObject {
    func detached() -> Self {
        let detached = type(of: self).init()
        for property in objectSchema.properties {
            guard let value = value(forKey: property.name) else {
                continue
            }
            if let detachable = value as? DetachableObject {
                detached.setValue(detachable.detached(), forKey: property.name)
            } else { // Then it is a primitive
                detached.setValue(value, forKey: property.name)
            }
        }
        return detached
    }
}

extension List: DetachableObject {
    func detached() -> List<Element> {
        let result = List<Element>()
        forEach {
            if let detachableObject = $0 as? DetachableObject,
               let element = detachableObject.detached() as? Element {
                result.append(element)
            } else { // Then it is a primitive
                result.append($0)
            }
        }
        return result
    }
}

extension Array where Element: DetachableObject {
    func detached() -> [Element] {
        var result = [Element]()
        forEach {
            result.append($0.detached())
        }
        return result
    }
}
