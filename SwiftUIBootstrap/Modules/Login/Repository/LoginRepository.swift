//
//  LoginRepository.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 15/02/2022.
//

import Foundation
import Combine
import RealmSwift


protocol LoginRepositoryInputProtocol  {
    func loginUser() async throws -> User
}


class LoginRepository<N:LoginServiceClientProtocol , S:LoginStorageProtocol> : BaseRepositoryStorage<S,N> , LoginRepositoryInputProtocol {
    var subscriptions: Set<AnyCancellable> = []

    @MainActor
    func loginUser() async throws -> User {
        do {
            guard let user = try await self.client.loginService().user else {
                throw AppError.buildNilDataError
            }
            try self.storage.saveUserInformation(user: user)
            guard let savedUser = self.storage.getUserInformation(userId: user.id ?? 0) else {
                throw AppError.buildNilDataError
            }
            return savedUser
        }
    }
}


