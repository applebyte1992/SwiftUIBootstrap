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
    private var cancellable = Set<AnyCancellable>()
    private var loginRepo: LoginRepositoryInputProtocol
    init(loginRepo: LoginRepositoryInputProtocol = LoginRepository(client: LoginServiceClient(), storage: UserStorage(storage: RealmContextManager()))) {
        self.loginRepo = loginRepo
         Publishers.CombineLatest($username, $password)
            .map { $0.count > 0 && $1.count > 0 }
            .assign(to: \.isValid, on: self)
            .store(in: &cancellable)
    }
    func login() {
        Task {
            do {
                let user = try await self.loginRepo.loginUser()
                print(user)
                self.isLogin = true
            } catch let error as AppError {
                print(error.message)
            }
        }
    }
    func dispose() {
        self.cancellable.forEach { object in
            object.cancel()
        }
        self.cancellable = []
    }
}
