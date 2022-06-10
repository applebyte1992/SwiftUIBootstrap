//
//  SuccessResponse.swift
//  TiCRM
//
//  Created by Masroor Elahi on 24/03/2022.
//

import Foundation

class SuccesssResponse: Codable {
    var response: String?
    init(response: String? = nil) {
        self.response = response
    }
    func toData() -> Data {
        let success: [String: String] = ["response": response ?? ""]
        return try! JSONSerialization.data(withJSONObject: success, options: .prettyPrinted) // swiftlint:disable:this force_try
    }
    var toID: Int {
        let responseId = Int(self.response ?? "0") ?? 0
        if responseId == 0 {
            fatalError("Response Id should not be zero")
        }
        return responseId
    }
}
