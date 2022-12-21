//
//  StringExtensions.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 17/02/2022.
//

import Foundation

extension String {
    static let HTTPGet = "GET"
    static let HTTPPost = "POST"
    static let HTTPPut = "PUT"
    func toObject<T: Codable>(type: T.Type) -> T? {
        let data = Data(self.utf8)
        do {
            return try data.decode(type: type)
        } catch let error {
            debugPrint(error)
            return nil
        }
    }
}
