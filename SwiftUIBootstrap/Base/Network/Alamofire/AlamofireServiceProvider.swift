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
    private var manager: Session
    public init(_ config: URLSessionConfiguration? = nil) {
        let config = config ?? URLSessionConfiguration.default
        self.manager = Session(configuration: config)
    }
    func fetch<T>(_ target: Target) async throws -> T where T: Decodable, T: Encodable {
        guard let url = target.endPoint else {
            throw AppError.buildNetworkError(networkError: NetworkError.init(message: GeneralError.invalidURL))
        }
        // Paramters
        let params: Parameters? = target.parameters
        // HTTP Method
        var method: HTTPMethod = .get
        // Encoding
        var encoding: ParameterEncoding = URLEncoding.default
        // Interceptor for headers and request retriers
        var requestInterceptor: RequestInterceptor?
        // Get alamofire values
        if let target = target as? AlamofireEndpoint {
            method = target.method
            encoding = target.encoding
            requestInterceptor = target.requestInterceptor
        }
        // Headers
        var httpHeaders: HTTPHeaders?
        if let headers = target.headers {
            httpHeaders = HTTPHeaders(headers)
        }
        let response = await manager.request(url, method: method, parameters: params, encoding: encoding, headers: httpHeaders, interceptor: requestInterceptor)
            .validate(NetworkError.validator)
            .serializingData(emptyResponseCodes: [200, 201, 202, 203, 204])
            .response
        switch response.result {
        case .success(let data):
            do {
                if data.isEmpty { return SuccesssResponse.init() as! T } // swiftlint:disable:this force_cast
                return try data.decode(type: T.self)
            } catch let exception {
                throw AppError.buildNetworkError(networkError: NetworkError.init(alamofireError: AFError.responseSerializationFailed(reason: AFError.ResponseSerializationFailureReason.decodingFailed(error: exception))))
            }
        case .failure(let exception):
            if case .responseValidationFailed(.customValidationFailed(let error)) = exception {
                throw error
            }
            throw AppError.buildNetworkError(networkError: NetworkError.init(alamofireError: exception))
        }
    }
}
