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
    var repo : LoginRepositoryInputProtocol!
    var subscriptions: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        subscriptions = []
    }
    
    func testLoginRepoUserInformationSuccess() {
        
        repo = LoginRepository(client: MockLoginClient(), storage: MockLoginStorage())
        var fetchedUser : User?
        var userError : AppError?
        
        let expectation = self.expectation(description: "Login repo successfull")
        let publisher = PassthroughSubject<User,AppError>()
        repo.loginUser(publisher: publisher)
        publisher.sink { error in
            switch error {
            case .finished:
                expectation.fulfill()
                break
            case .failure(let err):
                userError = err
                expectation.fulfill()
            }
        } receiveValue: { user in
            print(user)
            fetchedUser = user
        }.store(in: &subscriptions)
        waitForExpectations(timeout: 2)
        XCTAssertNil(userError)
        XCTAssertTrue(fetchedUser != nil, "Fetched user is nil")
        XCTAssertEqual(fetchedUser?.id, User.mock.id)
    }

}

class  MockLoginClient  : LoginServiceClientProtocol {
    
    var isError : Bool = false
    
    func loginService() -> AnyPublisher<UserResponse, AppError> {
        return Just.init(UserResponse.mock)
            .setFailureType(to: AppError.self)
            .delay(for: 1, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
            
    }
    
}


class MockLoginStorage : LoginStorageProtocol {
    
    
    func saveUserInformation(user : User) throws {
        print("Tesing call \(user.firstName ?? "")")
    }
    
    func getUserInformation(userId : Int) -> User? {
        return User.mock
    }
}
