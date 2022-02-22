//
//  LoginServiceAPITest.swift
//  SwiftUIBootstrapTests
//
//  Created by Masroor Elahi on 21/02/2022.
//

import XCTest
import Combine
import Alamofire


@testable import SwiftUIBootstrap

class LoginServiceAPITest: XCTestCase {
    
    var subscriptions: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        subscriptions = []
    }
    
    
    func testLoginAPISuccessResponse() {
        let service : LoginServiceClientProtocol = LoginServiceClient()
        
        var error: Error?
        var userResponse : UserResponse?
        let expectation = self.expectation(description: "Login Service Testing")
        
        service.loginService()
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                    break
                case .failure(let err):
                    error = err
                    expectation.fulfill()
                    break
                }
                
            } receiveValue: { user in
                userResponse = user
                print(user)
            }.store(in: &subscriptions)
        waitForExpectations(timeout: 10)
        
        XCTAssertNil(error)
        XCTAssertTrue(userResponse?.user?.id == 2)
    }
    
    func testLoginAPIEmptyResponse() {
        let service : LoginServiceClientProtocol = MockLoginServiceClient()
        
        var error: AppError?
        var userResponse : UserResponse?
        let expectation = self.expectation(description: "Login Service Testing")
        
        service.loginService()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    error = err
                    break
                }
                expectation.fulfill()
            } receiveValue: { user in
                userResponse = user
                print(user)
            }.store(in: &subscriptions)
        waitForExpectations(timeout: 10)
        XCTAssertTrue(error?.code == "404")
        XCTAssertTrue(userResponse?.user?.id == nil)
    }
}

//Mock

enum MockLogin {
    case authenticate
}

extension MockLogin : AlamofireEndpoint {
    var requestInterceptor: RequestInterceptor? {
        return nil
    }
    
    var parameters: Params? {
       return nil
    }
    
    var server: BaseServerInfo {
        return LoginServer()
    }
    
    var path: String {
        switch self {
        case .authenticate: return "/users/23"
        }
    }
    
    var httpMethod: String {
        return String.HTTPGet
    }
    
    //We can also use request adpater to add authorization headers
    //Request Adpater adds headers in existing
    
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    //Default Headers is ["Content-type": "application/json"]
    public var headers: Headers? {
        return ["Content-type": "application/json"]
    }
}


class MockLoginServiceClient : AlamofireProvider<MockLogin> , LoginServiceClientProtocol {
    
    init() {
        super.init()
    }
    
    func loginService() -> AnyPublisher<UserResponse, AppError>  {
        return super.fetch(.authenticate)
    }
}
