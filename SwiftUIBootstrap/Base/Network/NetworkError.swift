//
//  AppError.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 17/02/2022.
//

import Foundation
import Alamofire


fileprivate let generalNetworkErrorCode = "8000"


/// General network errors
enum GeneralNetworkError : Error {
    case invalidURL
    case other(String)
}

extension GeneralNetworkError : LocalizedError {
    
    public var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Provided url is invalid"
        case .other(let error):
            return error
        }
    }
}


/// Network Error is responsible of handling alamofire and custom network errors 
struct NetworkError: Codable , Error {
    var status: String
    var message: String
    
    /// Provided initializer to map alamofire error to  network error
    /// - Parameter alamofireError: AFError provided by Alamofire
    init(alamofireError : AFError) {
        self.status = "\(alamofireError.responseCode ?? 0)"
        self.message = alamofireError.localizedDescription
    }
    
    /// Provided initializer to map general error to  network error
    /// - Parameter message: GeneralNetworkError 
    init(message : GeneralNetworkError) {
        self.status = "\(generalNetworkErrorCode)"
        self.message = message.localizedDescription
    }
}

