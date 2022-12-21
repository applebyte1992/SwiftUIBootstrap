//
//  AppErrors.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 18/02/2022.
//

import Foundation

struct AppError: Error {
    var networkError: NetworkError?
    var dataError: GeneralError?
    var databaseError: RealmError?
    private init() {
        self.networkError = nil
        self.dataError = nil
        self.databaseError = nil
    }
    init(dataError: GeneralError) {
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
    var code: String {
        return networkError?.code ?? "\(generalStatusForOthers)"
    }
}

extension AppError: LocalizedError {
    public var localizedDescription: String {
        return networkError?.message ?? dataError?.localizedDescription ?? databaseError?.localizedDescription ?? unknownErrorMessage
    }
    var errorDescription: String? {
        return "SwiftUI Bootstrap"
    }
}

extension AppError {
    public static var buildNilDataError: AppError {
        return AppError(dataError: GeneralError.dataIsNil)
    }
    public static var somethingWentWrong: AppError {
        return AppError(dataError: GeneralError.somethingWentWrong)
    }
    static func buildDatabaseError(databaseError: RealmError) -> AppError {
        return AppError(databaseError: databaseError)
    }
    static func buildNetworkError(networkError: NetworkError) -> AppError {
        return AppError(networkError: networkError)
    }
}
