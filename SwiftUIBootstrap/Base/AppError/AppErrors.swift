//
//  AppErrors.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 18/02/2022.
//

import Foundation

// General Errors
private let generalStatusForOthers = 9000
private let unknownErrorMessage = "Unknow Error"

enum GeneralError: Error {
    case dataIsNil
    case unknownError(String)
}

extension GeneralError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .dataIsNil:
            return "Data is nil"
        case .unknownError(let error):
            return error
        }
    }
}

struct AppError: Error {
    var networkError: NetworkError?
    var dataError: GeneralError?
    var databaseError: RealmError?
    private init() {
        self.networkError = nil
        self.dataError = nil
        self.databaseError = nil
    }
    private init(dataError: GeneralError) {
        self.init()
        self.dataError = dataError
    }
    private init(networkError: NetworkError) {
        self.init()
        self.networkError = networkError
    }
    private init(databaseError: RealmError) {
        self.init()
        self.databaseError = databaseError
    }
    var message: String {
        return networkError?.message ?? dataError?.localizedDescription ?? databaseError?.localizedDescription ?? unknownErrorMessage
    }
    var code: String {
        return networkError?.status ?? "\(generalStatusForOthers)"
    }
}

extension AppError {
    public static var buildNilDataError: AppError {
        return AppError(dataError: GeneralError.dataIsNil)
    }
    static func buildDatabaseError(databaseError: RealmError) -> AppError {
        return AppError(databaseError: databaseError)
    }
    static func buildNetworkError(networkError: NetworkError) -> AppError {
        return AppError(networkError: networkError)
    }
}
