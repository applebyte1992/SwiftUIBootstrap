//
//  LoginRepository.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 15/02/2022.
//

import Foundation

protocol LoginRepositoryInputProtocol  {
    func loadUserInformation()
}

class LoginRepository<N:LoginServiceClientProtocol> : BaseRepository<N> , LoginRepositoryInputProtocol {
    func loadUserInformation() {
        self.client.loginService()
    }
}


class LoginRepoWithDB<N:LoginServiceClientProtocol , S:LoginStorageProtocol> : BaseRepositoryStorage<S,N> , LoginRepositoryInputProtocol {
    func loadUserInformation() {
        self.client.loginService()
        self.storage.saveUserInformation()
    }
}
