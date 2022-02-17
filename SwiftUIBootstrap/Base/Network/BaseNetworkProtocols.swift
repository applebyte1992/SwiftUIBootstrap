//
//  BaseServerInfo.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 15/02/2022.
//

import Foundation
import Alamofire
import Combine

/// A dictionary of parameters to apply to a `URLRequest`.
public typealias Params = [String: Any]

/// A dictionary of headers to apply to a `URLRequest`.
public typealias Headers = [String: String]


protocol BaseServerInfo: AnyObject {

    /// The target's base `URL` based on environment settings.
    var baseURL: String { get }

    /// Application key for getting the OAuth access token
    var apiKey: String { get }
    
}

//Default Implementation
extension BaseServerInfo {
    public var apiKey: String {
        return ""
    }
}

protocol BaseNetworkServiceClient : AnyObject { }

extension BaseNetworkServiceClient { }


//Network Endpoint Protocols
protocol BaseNetworkEndpoint {

    /// Base information about the server common for all endpoints
    var server: BaseServerInfo { get }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }

    /// The HTTP method used in the request.
    var httpMethod: String { get }

    /// The HTTP method used in the request.
    var headers: Headers? { get }

    /// The parameters for the call
    var parameters: Params? { get }
    

}

extension BaseNetworkEndpoint {

    /// Utility computed property to make the complete URL
    public var endPoint: URL? {
        return URL(string: server.baseURL + path)
    }

    /// Default value for HTTP method is GET
    public var httpMethod: String { return .HTTPGet }

    /// Default value for HTTP headers is json
    public var headers: Headers? {
        return ["Content-type": "application/json"]
    }

    /// Default parameters are nil
//    public var parameters: Params? { return nil }

}

protocol BaseNetworkService: AnyObject {
    associatedtype Target: BaseNetworkEndpoint
    /// Session configuration can be set for this API
    var config: URLSessionConfiguration? { get set }

    /// actual method that handles the network call and relay the response back after parsing json
    func fetch<T: Codable>(_ target: Target) -> AnyPublisher<T, NetworkError>
}

