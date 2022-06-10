//
//  GeneralError.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 10/06/2022.
//

import Foundation

// General Errors
let generalStatusForOthers = 9000
let unknownErrorMessage = "Unknow Error"

let generalNetworkErrorCode = "8000"

/// General network errors
enum GeneralError: Error {
    case invalidURL
    case invalidCredentials
    case generalAuthError
    case somethingWentWrong
    case dataIsNil
    case noEntitlements
    case mustChangePassword
    case unknownError(String)
}

extension GeneralError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Provided url is invalid"
        case .invalidCredentials:
            return "Invalid username/password."
        case .generalAuthError:
            return "Unexpected error occurred during authentication."
        case .unknownError(let error):
            return error
        case .dataIsNil:
            return "Data is nil"
        case .somethingWentWrong:
            return "Something went wrong, please retry after some time or contact support."
        case .noEntitlements:
            return "You don't have access to the app. Please contact customer support."
        case .mustChangePassword:
            return "Please change your password first"
        }
    }
}
