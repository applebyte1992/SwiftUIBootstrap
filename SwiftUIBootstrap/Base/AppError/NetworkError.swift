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
    init(error: Error) {
        let nserror = error as NSError
        self.code = nserror.code.description
        self.message = nserror.localizedDescription
        self.requestURL = nil
    }
    private init(errorCode: String? = nil, errorMessage: String? = nil, requestURL: String? = nil) {
        self.code = errorCode
        self.message = errorMessage
        self.requestURL = requestURL
    }
    /// Custom Error Parser
    /// - Parameters:
    ///   - data: Data of error coming from api
    ///   - code: Code of the api response
    ///   - message: Message of the error
    /// - Returns: App Error object returned
    static func getError(_ data: Data? , _ code: Int , _ message: String = "" ) -> AppError {
        do {
            if let err = try data?.decode(type: NetworkError.self) {
                return AppError.buildNetworkError(networkError: err)
            } else {
                return AppError.buildNetworkError(networkError: NetworkError(errorCode: "\(code)", errorMessage: message, requestURL: nil))
            }
        } catch let error {
            return AppError.buildNetworkError(networkError: NetworkError.init(error: error))
        }
    }
    var isErrorValid: Bool {
        return !(self.code == nil && self.message == nil && self.requestURL == nil)
    }
}

extension NetworkError {
    public static let validator: DataRequest.Validation = { request, response, data in
        showRequestDetail(request: request, response: response, data: data)
        switch response.statusCode {
        case 403:
            return .failure(NetworkError.getError(data , response.statusCode , GeneralError.generalAuthError.localizedDescription))
        case 400..<402, 404..<499:
            return .failure(NetworkError.getError(data , response.statusCode , GeneralError.somethingWentWrong.localizedDescription))
        case 500..<599:
            return .failure(NetworkError.getError(data , response.statusCode , GeneralError.somethingWentWrong.localizedDescription))
        case 200..<399:
                return .success(())
        default:
            return .success(())
        }
    }
    static func showRequestDetail(request: URLRequest?, response: HTTPURLResponse, data: Data?) { // swiftlint:disable:this function_body_length
         let responseCode = response.statusCode
        switch responseCode {
        case 200..<399:
            DispatchQueue.global(qos: .background).async {
                var logString: String = ""
                logString = "\n\n\n✅✅✅ ------- Success Response Start ------- ✅✅✅ \n"
                logString += ""+(response.url?.absoluteString ?? "")
                logString += "\n=========   allHTTPHeaderFields   ========== \n"
                logString += "\(request?.allHTTPHeaderFields ?? [:])"
                logString += "\n=========   HTTP Status code   ========== \n"
                logString += "\(response.statusCode)"
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
        case 400..<599:
            DispatchQueue.global(qos: .background).async {
                var logString: String = ""
                logString = "\n\n\n❌❌❌❌ ------- Failure Response Start ------- ❌❌❌❌\n"
                logString += ""+(response.url?.absoluteString ?? "")
                logString += "\n=========   allHTTPHeaderFields   ========== \n"
                logString += "\(request?.allHTTPHeaderFields ?? [:])"
                logString += "\n=========   HTTP Status code   ========== \n"
                logString += "\(response.statusCode)"
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
        default:
            break
        }
    }
}
