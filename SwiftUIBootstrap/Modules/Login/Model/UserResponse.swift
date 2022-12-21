//
//  UserResponse.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 17/02/2022.
//

import Foundation
class UserResponse: Codable {
    let code: Int?
    let message: String?
    let user: User?
    enum CodingKeys: String, CodingKey {
        case code
        case message
        case user = "data"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        user = try values.decodeIfPresent(User.self, forKey: .user)
    }
}

extension UserResponse {
    static var mock: UserResponse {
        return """
        {
            "code": 0,
            "message": "success",
            "data": {
                "Id": 126298,
                "Name": "Developer",
                "Email": "masroor@gmail.com",
                "Token": "8758308d-daa2-4d47-bea7-cacdde87b948"
            }
        }
        """.toObject(type: UserResponse.self)!
    }
    static var mockFailure: UserResponse {
        return """
        {
            "code": 1,
            "message": "invalid username or password",
            "data": null
        }
        """.toObject(type: UserResponse.self)!
    }
}
