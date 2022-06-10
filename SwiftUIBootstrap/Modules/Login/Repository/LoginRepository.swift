//
//  LoginRepository.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 15/02/2022.
//

import Foundation
import Combine
import RealmSwift

protocol LoginRepositoryInputProtocol {
    func loginUser(email: String, password: String) async throws -> User
}
class LoginRepository<N: LoginServiceClientProtocol,S: LoginStorageProtocol>: BaseRepositoryStorage<S,N>,LoginRepositoryInputProtocol {

    func loginUser(email: String, password: String) async throws -> User {
        do {
            guard let response = try await self.client.loginService(request: LoginRequest.init(email: email, password: password)).user else {
                throw AppError.init(dataError: GeneralError.invalidCredentials)
            }
            return try await self.saveUserInformation(user: response)
        }
    }
    @MainActor
    private func saveUserInformation(user: User)throws -> User {
        try self.storage.saveUserInformation(user: user)
        guard let savedUser = self.storage.getUserInformation(userId: user.id ) else {
            fatalError("User information not returned from Database")
        }
        return savedUser
    }
}
