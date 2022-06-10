//
//  AppError.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 17/02/2022.
//

import Foundation
import Alamofire

/// Network Error is responsible of handling alamofire and custom network errors
struct NetworkError: Codable , Error {
    var code: String?
    var message: String?
    var requestURL: String?
    /// Provided initializer to map alamofire error to  network error
    /// - Parameter alamofireError: AFError provided by Alamofire
    init(alamofireError: AFError) {
        self.code = "\(alamofireError.responseCode ?? 0)"
        self.message = alamofireError.localizedDescription
    }
    /// Provided initializer to map general error to  network error
    /// - Parameter message: GeneralNetworkError
    init(message: GeneralError) {
        self.code = "\(generalNetworkErrorCode)"
        self.message = message.localizedDescription
    }
    private init(errorCode: String? = nil, errorMessage: String? = nil, requestURL: String? = nil) {
        self.code = errorCode
        self.message = errorMessage
        self.requestURL = requestURL
    }
    static func getError(_ data: Data? , _ code: Int , _ message: String = "" ) -> AppError {
        if let err = data?.decode(type: NetworkError.self) {
            return AppError.buildNetworkError(networkError: err)
        } else if let responseData = data , !responseData.isEmpty {
            return AppError.buildNetworkError(networkError: NetworkError(errorCode: "\(code)", errorMessage: String.init(data: responseData, encoding: .utf8), requestURL: nil))
        } else {
            return AppError.buildNetworkError(networkError: NetworkError(errorCode: "\(code)", errorMessage: message, requestURL: nil))
        }
    }
    var isErrorValid: Bool {
        return !(self.code == nil && self.message == nil && self.requestURL == nil)
    }
}

extension NetworkError {
    public static let validator: DataRequest.Validation = { request, response, data in
        switch response.statusCode {
        case 403:
            showRequestDetailForFailure(request: request, reponse: response, data: data)
            return .failure(NetworkError.getError(data , response.statusCode , GeneralError.generalAuthError.localizedDescription))
        case 400..<402, 404..<499:
            showRequestDetailForFailure(request: request, reponse: response, data: data)
            return .failure(NetworkError.getError(data , response.statusCode , GeneralError.somethingWentWrong.localizedDescription))
        case 500..<599:
            showRequestDetailForFailure(request: request, reponse: response, data: data)
            return .failure(NetworkError.getError(data , response.statusCode , GeneralError.somethingWentWrong.localizedDescription))
        case 200..<399:
                return .success(())
        default:
            showRequestDetailForSuccess(request: request, reponse: response, data: data)
            return .success(())
        }
    }
    static func showRequestDetailForSuccess(request: URLRequest?, reponse: HTTPURLResponse, data: Data?) {
        DispatchQueue.global(qos: .background).async {
            var logString: String = ""
            logString = "\n\n\n✅✅✅ ------- Success Response Start ------- ✅✅✅ \n"
            logString += ""+(reponse.url?.absoluteString ?? "")
            logString += "\n=========   allHTTPHeaderFields   ========== \n"
            logString += "\(request?.allHTTPHeaderFields ?? [:])"
            logString += "\n=========   HTTP Status code   ========== \n"
            logString += "\(reponse.statusCode)"
            if let bodyData: Data = request?.httpBody {
                let bodyString = String(data: bodyData, encoding: String.Encoding.utf8)
                logString += "\n=========   Request httpBody   ========== \n" + (bodyString ?? "")
            } else {
                logString += "\n=========   Request httpBody   ========== \n" + "Found Request Body Nil"
            }
            if let responseData: Data = data {
                let responseString = String(data: responseData, encoding: String.Encoding.utf8)
                logString += "\n=========   Response Body   ========== \n" + (responseString ?? "")
            } else {
                logString += "\n=========   Response Body   ========== \n" + "Found Response Body Nil"
            }
            logString += "\n✅✅✅ ------- Success Response End ------- ✅✅✅ \n\n\n"
            print(logString)
        }
    }
    static func showRequestDetailForFailure(request: URLRequest?, reponse: HTTPURLResponse, data: Data?) {
        DispatchQueue.global(qos: .background).async {
            var logString: String = ""
            logString = "\n\n\n❌❌❌❌ ------- Failure Response Start ------- ❌❌❌❌\n"
            logString += ""+(reponse.url?.absoluteString ?? "")
            logString += "\n=========   allHTTPHeaderFields   ========== \n"
            logString += "\(request?.allHTTPHeaderFields ?? [:])"
            logString += "\n=========   HTTP Status code   ========== \n"
            logString += "\(reponse.statusCode)"
            if let bodyData: Data = request?.httpBody {
                let bodyString = String(data: bodyData, encoding: String.Encoding.utf8)
                logString += "\n=========   Request httpBody   ========== \n" + (bodyString ?? "")
            } else {
                logString += "\n=========   Request httpBody   ========== \n" + "Found Request Body Nil"
            }
            if let responseData: Data = data {
                let responseString = String(data: responseData, encoding: String.Encoding.utf8)
                logString += "\n=========   Response Body   ========== \n" + (responseString ?? "")
            } else {
                logString += "\n=========   Response Body   ========== \n" + "Found Response Body Nil"
            }
            logString += "\n❌❌❌❌ ------- Failure Response End ------- ❌❌❌❌\n\n\n"
            print(logString)
        }
    }
}
