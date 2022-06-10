//
//  DataExtension.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 10/06/2022.
//

import Foundation
extension Data {
    func decode<T: Decodable>(type: T.Type, enableLog: Bool = true) -> T? {
        do {
            return try JSONDecoder().decode(type, from: self)
        } catch let error {
            if enableLog {
                debugPrint(error)
            }
            return nil
        }
    }
}
