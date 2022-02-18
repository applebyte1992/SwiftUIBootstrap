//
//  AppError.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 17/02/2022.
//

import Foundation
import Alamofire


fileprivate let generalNetworkErrorCode = "8000"

enum GeneralNetworkError : String {
    case invalidURL = "Invalid URL"
}

struct NetworkError: Codable , Error {
    var status: String
    var message: String
    init(alamofireError : AFError) {
        self.status = "\(alamofireError.responseCode ?? 0)"
        self.message = alamofireError.localizedDescription
    }
    
    init(message : GeneralNetworkError) {
        self.status = "\(generalNetworkErrorCode)"
        self.message = message.rawValue
    }
}

