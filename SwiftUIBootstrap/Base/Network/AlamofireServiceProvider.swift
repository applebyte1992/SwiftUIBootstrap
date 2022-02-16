//
//  AlamofireServiceProvider.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 16/02/2022.
//

import Foundation
import Alamofire
import Combine
import UIKit


struct NetworkError: Error {
    let initialError: AFError
    let backendError: BackendError?
}

struct BackendError: Codable, Error {
    var status: String
    var message: String
}


class F11AlamofireProvider<Target: BaseNetworkEndpoint>: BaseNetworkService {
    
    
    public var config: URLSessionConfiguration? {
        didSet {
            if let config = config {
                manager = Session(configuration: config)
            }
        }
    }
    
    public var manager: Session
    
    public init(_ config: URLSessionConfiguration? = nil) {
        let config = config ?? URLSessionConfiguration.default
        self.manager = Session(configuration: config)
    }
    

    func fetch<T>(_ target: Target, completion: @escaping (T?, Error?) -> Void) -> AnyPublisher<T, NetworkError> where T : Decodable, T : Encodable {
        guard let url = target.endPoint else {
            return Fail(error: NetworkError.init(initialError: AFError.invalidURL(url: ""), backendError: nil)).eraseToAnyPublisher()
        }
        let headers: HTTPHeaders? = [:]
        let params: Parameters? = target.parameters
        
        // Default values
        var method: HTTPMethod = .get
        var encoding: ParameterEncoding = URLEncoding.default
        var requestInterceptor :  RequestInterceptor? = nil
        // Get alamofire values
        if let target = target as? AlamofireEndpoint {
            method = target.method
            encoding = target.encoding
            requestInterceptor = target.requestInterceptor
        }
        
        return manager.request(url, method: method, parameters: params, encoding: encoding, headers: headers, interceptor: requestInterceptor)
            .validate()
            .publishDecodable(type: T.self , emptyResponseCodes: [200])
            .value()
            .mapError({err in NetworkError(initialError: err, backendError: nil)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}

struct EmptyResponse : Codable {
    
}

extension Decodable {

    /// Try to deserialize directly from JSON data
    static func decode(data: Data) -> Self? {
        let decoder = JSONDecoder()
        return try? decoder.decode(Self.self, from: data)
    }
}

