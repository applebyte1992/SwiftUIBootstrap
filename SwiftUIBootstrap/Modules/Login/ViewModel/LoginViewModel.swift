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
    @Published var isLogin = false
    
    var isValid = false
    
    var userPublisher : CurrentValueSubject <User,AppError>!
    
    
    private var cancellable = Set<AnyCancellable>()
    private var loginRepo : LoginRepositoryInputProtocol
    
    init(loginRepo : LoginRepositoryInputProtocol = LoginRepository(client: LoginServiceClient(), storage: UserStorage(storage: RealmContextManager()))){
        self.loginRepo = loginRepo
         Publishers.CombineLatest($username, $password)
            .map { $0.count > 0 && $1.count > 0 }
            .assign(to: \.isValid, on: self)
            .store(in: &cancellable)
    }
    
    func login() {
        userPublisher = CurrentValueSubject<User,AppError>(User())
        loginRepo.loginUser(publisher: userPublisher)
        userPublisher.sink { error in
            switch error {
            case .finished:
                print("Finished")
                self.isLogin = true
                break
            case .failure(let er):
                print(er)
                break
            }                
        } receiveValue: { user in
            print(user)
        }.store(in: &cancellable)
    }
    
    func dispose() {
        self.loginRepo.dispose()
        self.cancellable.forEach { object in
            object.cancel()
        }
        self.cancellable = []
    }
    
}


