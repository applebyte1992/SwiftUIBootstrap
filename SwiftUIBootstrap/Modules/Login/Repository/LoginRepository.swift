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
    func loginUser(publisher: PassthroughSubject<User, AppError>)
}


class LoginRepository<N:LoginServiceClientProtocol , S:LoginStorageProtocol> : BaseRepositoryStorage<S,N> , LoginRepositoryInputProtocol {
    var subscriptions: Set<AnyCancellable> = []
    
    func loginUser(publisher: PassthroughSubject<User, AppError>) {
        self.client.loginService()
            .sink { publisher.send(completion: $0) } receiveValue: { [weak self] in
                self?.handleUserResponse(publisher: publisher, userResponse: $0)
            }.store(in: &subscriptions)
    }
    
    private func handleUserResponse(publisher : PassthroughSubject<User,AppError> , userResponse : UserResponse) {
        do {
            try self.storage.saveUserInformation(user: userResponse.user!)
            if let user = self.storage.getUserInformation(userId: userResponse.user?.id ?? 0) {
                publisher.send(user)
            }
        } catch let err as AppError {
            publisher.send(completion: .failure(err))
        } catch {
            print("Generic Exception")
        }
    }
}


