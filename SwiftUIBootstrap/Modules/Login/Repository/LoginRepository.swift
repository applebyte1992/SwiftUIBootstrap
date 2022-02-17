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
    func loginUser()
    func loginUser2() -> AnyPublisher<UserResponse,NetworkError>
    func loginUser3() -> Future<User?,NetworkError>
    
    func loginUser4(publisher : PassthroughSubject<User,NetworkError>)
}


class LoginRepository<N:LoginServiceClientProtocol , S:LoginStorageProtocol> : BaseRepositoryStorage<S,N> , LoginRepositoryInputProtocol {
   
    
    var subscriptions: Set<AnyCancellable> = []
    
    func loginUser() {
        self.client.loginService()
            .sink { print ("completion: \($0)") } receiveValue: {
                print("Value : \($0)")
            }.store(in: &subscriptions)
        
    }
    
    func loginUser2() -> AnyPublisher<UserResponse,NetworkError> {
        return Future { promise in
            self.client.loginService().sink { completed in
                switch completed {
                case .finished: break
                case .failure(let err):
                    promise(.failure(err))
                }
            } receiveValue: { response in
                promise(.success(response))
            }.store(in: &self.subscriptions)
        }.eraseToAnyPublisher()
    }
    
    func loginUser3() -> Future<User?,NetworkError> {
        return Future { promise in
            self.client.loginService().sink { completed in
                switch completed {
                case .finished: break
                case .failure(let err):
                    promise(.failure(err))
                }
            } receiveValue: { response in
                promise(.success(response.user))
            }.store(in: &self.subscriptions)
        }
    }
    
    func loginUser4(publisher: PassthroughSubject<User, NetworkError>) {
        self.client.loginService()
            .sink { publisher.send(completion: $0)} receiveValue: {
                publisher.send($0.user!)
            }.store(in: &subscriptions)
    }
    
    
}


