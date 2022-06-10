//
//  DictionaryExtension.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 07/06/2022.
//

import Foundation

public extension Dictionary {
    /// Encode to Data
    func encode() -> Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: [])
    }
}
