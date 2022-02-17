//
//  AppError.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 17/02/2022.
//

import Foundation
import Alamofire

struct NetworkError: Error {
    let initialError: AFError
    let backendError: BackendError?
}

struct BackendError: Codable, Error {
    var status: String
    var message: String
}
