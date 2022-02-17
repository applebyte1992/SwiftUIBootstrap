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
    
    var abc = PassthroughSubject<User,NetworkError>()
    
    private var cancellable = Set<AnyCancellable>()
    private var loginRepo : LoginRepositoryInputProtocol = LoginRepository(client: LoginServiceClient(), storage: LoginStorage(storage: RealmContextManager()))

    init(){
         Publishers.CombineLatest($username, $password)
            .map { $0.count > 0 && $1.count > 0 }
            .assign(to: \.isValid, on: self)
            .store(in: &cancellable)
    }
    
    func login() {
//
//        loginRepo.loginUser()
//        loginRepo.loginUser3().sink { err in
//            switch err {
//            case .finished: break;
//            case .failure(let err):
//                print(err);
//            }
//
//        } receiveValue: { user in
//            print(user)
//        }
        
        loginRepo.loginUser4(publisher: abc)
        
        abc.sink { error in
            print(error)
        } receiveValue: { user in
            print(user)
        }.store(in: &cancellable)

            
    }
}


