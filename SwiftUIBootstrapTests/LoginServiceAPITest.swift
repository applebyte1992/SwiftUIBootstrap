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
    }
    func testLoginAPIEmptyResponse() {
    }
}

// Mock

enum MockLogin {
    case authenticate
}

extension MockLogin: AlamofireEndpoint {
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
    // We can also use request adpater to add authorization headers
    // Request Adpater adds headers in existing
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    // Default Headers is ["Content-type": "application/json"]
    public var headers: Headers? {
        return ["Content-type": "application/json"]
    }
}

class MockLoginServiceClient: AlamofireProvider<MockLogin>,LoginServiceClientProtocol {
    func loginService() async throws -> UserResponse {
        return try await super.fetch(.authenticate)
    }
    init() {
        super.init()
    }
}
