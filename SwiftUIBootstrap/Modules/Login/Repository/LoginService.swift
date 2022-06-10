//
//  LoginService.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 16/02/2022.
//

import Foundation
import Alamofire
import Combine

/// Defines the endpoints available for the Authentication API
enum LoginService {
    /// Endpoint for the API:
    case authenticate(LoginRequest)
}

/// Implementation of the Endpoint protocol for Token Service
extension LoginService: AlamofireEndpoint {
    var requestInterceptor: RequestInterceptor? {
        return nil
    }
    var parameters: Params? {
        switch self {
        case .authenticate(let loginRequest):
            return loginRequest.encode()
        }
    }
    var server: BaseServerInfo {
        return LoginServer()
    }
    var path: String {
        switch self {
        case .authenticate: return "/authaccount/login"
        }
    }
    var httpMethod: String {
        return String.HTTPPost
    }
    // We can also use request adpater to add authorization headers
    // Request Adpater adds headers in existing
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    // Default Headers is ["Content-type": "application/json"]
    public var headers: Headers? {
        return ["Content-type": "application/json"]
    }
}

protocol LoginServiceClientProtocol: BaseNetworkServiceClient {
    func loginService(request: LoginRequest) async throws -> UserResponse
}

/// API Client for the Authentication API
class LoginServiceClient: AlamofireProvider<LoginService>,LoginServiceClientProtocol {
    init() {
        super.init()
    }
    func loginService(request: LoginRequest) async throws -> UserResponse {
        return try await super.fetch(.authenticate(request))
    }

}
