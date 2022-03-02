//
//  LoginRepositoryTest.swift
//  SwiftUIBootstrapTests
//
//  Created by Masroor Elahi on 21/02/2022.
//

import XCTest
import Combine

@testable import SwiftUIBootstrap

class LoginRepositoryTest: XCTestCase {
    var repo: LoginRepositoryInputProtocol!
    var subscriptions: Set<AnyCancellable> = []
    override func setUp() {
        super.setUp()
        subscriptions = []
    }
    func testLoginRepoUserInformationSuccess() {
    }

}

class  MockLoginClient: LoginServiceClientProtocol {
    func loginService() async throws -> UserResponse {
        return UserResponse.mock
    }
    var isError: Bool = false
}

class MockLoginStorage: LoginStorageProtocol {
    func saveUserInformation(user: User) throws {
        print("Tesing call \(user.firstName ?? "")")
    }
    func getUserInformation(userId: Int) -> User? {
        return User.mock
    }
}
