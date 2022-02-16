//
//  LoginService.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 16/02/2022.
//

import Foundation
import Alamofire



/// Defines the endpoints available for the Authentication API
public enum LoginService {
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
        case .authenticate: return "/api/login"
            
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
        return ["Content-Type" : "application/x-www-form-urlencoded"]
    }
}

protocol LoginServiceClientProtocol : BaseNetworkServiceClient {
//    func loginUser(request : LoginRequestModel , completion: @escaping ((User?, Error?) -> Void))
    func loginService()
}

/// API Client for the Authentication API
class LoginServiceClient : AlamofireProvider<LoginService> , LoginServiceClientProtocol {
    
    
    
    init() {
        super.init()
    }
    
    func loginService() {
        
    }
    
    /// Get an access token by providing user credentials
//    func loginUser(request : LoginRequestModel , completion: @escaping ((User?, Error?) -> Void)) {
//        _ = fetch(.authenticate(userRequest : request), completion: completion)
//    }

}
