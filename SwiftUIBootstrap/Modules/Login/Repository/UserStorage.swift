//
//  LoginStorage.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 16/02/2022.
//

import Foundation

protocol LoginStorageProtocol: BaseStorageClient {
    func saveUserInformation(user: User) throws
    func getUserInformation(userId: Int) -> User?
}

class UserStorage: BaseDatabaseStorage,LoginStorageProtocol {
    func saveUserInformation(user: User) throws {
        try self.storage.save(object: user)
    }
    func getUserInformation(userId: Int) -> User? {
        var user: User?
        self.storage.fetch(User.self, predicate: NSPredicate.init(format: "id == %d", userId), sorted: nil) { usersList in
            user = usersList.first?.detached()
        }
        return user
    }
}
