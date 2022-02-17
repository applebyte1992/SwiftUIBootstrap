//
//  DecodableExtension.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 17/02/2022.
//

import Foundation


extension Decodable {

    /// Try to deserialize directly from JSON data
    static func decode(data: Data) -> Self? {
        let decoder = JSONDecoder()
        return try? decoder.decode(Self.self, from: data)
    }
}
