//
//  LoginViewModel.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 15/02/2022.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var username = ""
    @Published var password = ""
    var isValid = false
    
    private var cancellable = Set<AnyCancellable>()
    private var loginRepo : LoginRepositoryInputProtocol = LoginRepository(client: LoginServiceClient(), storage: LoginStorage(storage: RealmContextManager()))

    init(){
         Publishers.CombineLatest($username, $password)
            .map { $0.count > 0 && $1.count > 0 }
            .assign(to: \.isValid, on: self)
            .store(in: &cancellable)
    }
    
    func login() {
        loginRepo.loginUser()
    }
}
