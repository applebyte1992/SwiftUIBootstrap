//
//  LoginRequest.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 07/06/2022.
//

import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
}
// MARK: - Mock Models
extension LoginRequest {
    static var mockSuccess: LoginRequest {
        return LoginRequest(email: "masroor@gmail.com", password: "123456")
    }
    static var mockFailed: LoginRequest {
        return LoginRequest(email: "masroor@gmail.com", password: "1234599")
    }
}
