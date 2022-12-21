//
//  LoginRepositoryTest.swift
//  SwiftUIBootstrapTests
//
//  Created by Masroor Elahi on 21/02/2022.
//

import XCTest
import Combine
import RealmSwift

@testable import SwiftUIBootstrap

class LoginRepositoryTest: XCTestCase {
    var repo: LoginRepositoryInputProtocol!
    override func setUp() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        super.setUp()
    }
    func testLoginRepoUserInformationSuccess() async {
        self.repo = LoginRepository(client: MockLoginClient(), storage: MockLoginStorage())
        let mockUser = LoginRequest.mockSuccess
        do {
            let response = try await self.repo.loginUser(email: mockUser.email, password: mockUser.password)
            XCTAssertTrue(response.id == UserResponse.mock.user?.id)
        } catch {
            XCTFail("Failed login success test")
        }
    }
    func testLoginRepoUserInformationFailure() async {
        self.repo = LoginRepository(client: MockLoginClient(), storage: MockLoginStorage())
        let mockUser = LoginRequest.mockFailed
        do {
            _ = try await self.repo.loginUser(email: mockUser.email, password: mockUser.password)
            XCTFail("Response returned on wrong credentials")
        } catch {
            XCTAssert(true, "Exception received on wrong credentials")
        }
    }
}

class MockLoginClient: LoginServiceClientProtocol {
    func loginService(request: LoginRequest) async throws -> UserResponse {
        if request.email == LoginRequest.mockSuccess.email && request.password == LoginRequest.mockSuccess.password { return UserResponse.mock }
        throw AppError.init(dataError: GeneralError.invalidCredentials)
    }
}

class MockLoginStorage: LoginStorageProtocol {
    var user: SwiftUIBootstrap.User!
    func saveUserInformation(user: SwiftUIBootstrap.User) throws {
        self.user = user
    }
    func getUserInformation(userId: Int) -> SwiftUIBootstrap.User? {
        return user
    }
}
