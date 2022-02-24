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
    func loginUser(publisher: CurrentValueSubject<User, AppError>)
    func dispose()
}


class LoginRepository<N:LoginServiceClientProtocol , S:LoginStorageProtocol> : BaseRepositoryStorage<S,N> , LoginRepositoryInputProtocol {
    var subscriptions: Set<AnyCancellable> = []
    
    func loginUser(publisher: CurrentValueSubject<User, AppError>) {
        self.client.loginService().sink { completion in
            switch completion {
            case .failure(_):
                publisher.send(completion: completion)
            case .finished:
                publisher.send(completion: completion)
            }
        } receiveValue: {[weak self] user in
            self?.handleUserResponse(publisher: publisher, userResponse: user)
        }.store(in: &subscriptions)

        
    }
    
    private func handleUserResponse(publisher : CurrentValueSubject<User,AppError> , userResponse : UserResponse) {
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
    
    func dispose() {
        self.subscriptions.forEach { object in
            object.cancel()
        }
        self.subscriptions = []
    }
}


