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


/// This class provided an implmentation of BaseNetworkService by using Alamofire. This provider is using combine with alamofire in order to send response back.
class AlamofireProvider<Target: BaseNetworkEndpoint>: BaseNetworkService {
    
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
    
    func fetch<T>(_ target: Target) -> AnyPublisher<T, AppError> where T : Decodable, T : Encodable {
        guard let url = target.endPoint else {
            return Fail(error: AppError.buildNetworkError(networkError: NetworkError.init(message: GeneralNetworkError.invalidURL))).eraseToAnyPublisher()
        }
        //Paramters
        let params: Parameters? = target.parameters
        //HTTP Method
        var method: HTTPMethod = .get
        //Encoding
        var encoding: ParameterEncoding = URLEncoding.default
        //Interceptor for headers and request retriers
        var requestInterceptor :  RequestInterceptor? = nil
        // Get alamofire values
        if let target = target as? AlamofireEndpoint {
            method = target.method
            encoding = target.encoding
            requestInterceptor = target.requestInterceptor
        }
        //Headers
        var httpHeaders : HTTPHeaders? = nil
        if let headers = target.headers {
            httpHeaders = HTTPHeaders(headers)
        }
        
        return manager.request(url, method: method, parameters: params, encoding: encoding, headers: httpHeaders, interceptor: requestInterceptor)
            .validate()
            .publishDecodable(type: T.self , emptyResponseCodes: [200, 204, 205])
            .value()
            .mapError({ err in
                AppError.buildNetworkError(networkError: NetworkError.init(alamofireError: err))
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}

