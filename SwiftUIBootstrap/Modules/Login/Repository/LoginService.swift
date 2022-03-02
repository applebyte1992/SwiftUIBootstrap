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
    case authenticate
}

/// Implementation of the Endpoint protocol for Token Service
extension LoginService: AlamofireEndpoint {
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
        case .authenticate: return "/users/2"
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

protocol LoginServiceClientProtocol: BaseNetworkServiceClient {
    func loginService() async throws -> UserResponse
}

/// API Client for the Authentication API
class LoginServiceClient: AlamofireProvider<LoginService>,LoginServiceClientProtocol {
    init() {
        super.init()
    }
    func loginService() async throws -> UserResponse {
        return try await super.fetch(.authenticate)
    }

}
