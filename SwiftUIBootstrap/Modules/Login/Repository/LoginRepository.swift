//
//  LoginRepository.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 15/02/2022.
//

import Foundation
import Combine


protocol LoginRepositoryInputProtocol  {
    func loginUser()
}


class LoginRepository<N:LoginServiceClientProtocol , S:LoginStorageProtocol> : BaseRepositoryStorage<S,N> , LoginRepositoryInputProtocol {
    
    var subscriptions: Set<AnyCancellable> = []
    
    func loginUser() {
        self.client.loginService()
            .sink { print ("completion: \($0)") } receiveValue: {
                print("Value : \($0)")
            }.store(in: &subscriptions)
        
    }
    
    func login2() {
        self.client.loginService()
            .sink { completed in
                switch completed {
                case .finished: break
                case .failure(let err):
                    print(err)
                }
            } receiveValue: { d1 in
                print(d1)
            }.store(in: &subscriptions)
    }
    
}


