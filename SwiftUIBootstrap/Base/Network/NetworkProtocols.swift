//
//  BaseServerInfo.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 15/02/2022.
//

import Foundation


/// A dictionary of parameters to apply to a `URLRequest`.
public typealias Params = [String: Any]

/// A dictionary of headers to apply to a `URLRequest`.
public typealias Headers = [String: String]


protocol BaseServerInfo: AnyObject {

    /// The target's base `URL` based on environment settings.
    var baseURL: String { get }

    /// Application key for getting the OAuth access token
    var apiKey: String { get }
    
}

//Default Implementation
extension BaseServerInfo {
    public var apiKey: String {
        return ""
    }
}
