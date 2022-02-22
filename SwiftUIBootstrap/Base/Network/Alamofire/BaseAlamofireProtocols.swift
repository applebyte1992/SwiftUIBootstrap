//
//  BaseAlamofireProtocols.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 22/02/2022.
//

import Foundation
import Alamofire


protocol AlamofireEndpoint: BaseNetworkEndpoint {

    /// The HTTP method used in the request.
    var method: HTTPMethod { get }

    /// The encoding defining how to send the parameters
    var encoding: ParameterEncoding { get }

    var requestInterceptor : RequestInterceptor? { get }
    
}

extension AlamofireEndpoint {

    /// Wrapping HTTP method
    public var method: HTTPMethod { return HTTPMethod(rawValue: httpMethod) }
    /// Default value for Parameters encoding depends on the HTTP Method
    public var encoding: ParameterEncoding { return URLEncoding.default }
    
    public var requestAdapt : RequestAdapter? { return nil }
    
    public var requestRetrier : RequestRetrier? { return nil }

}
