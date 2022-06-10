//
//  User.swift
//  SwiftUIBootstrap
//
//  Created by Masroor Elahi on 17/02/2022.
//
import Foundation
import RealmSwift

@objcMembers class User: Object, Codable {
    dynamic var id: Int = 0
    dynamic var name: String?
    dynamic var email: String?
    dynamic var token: String?
    override init() { }
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case email = "Email"
        case token = "Token"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }
}
extension User {
    static var mock: User {
        return
            """
            {
                "Id": 126298,
                "Name": "Developer",
                "Email": "masroor@gmail.com",
                "Token": "8758308d-daa2-4d47-bea7-cacdde87b948"
            }
            """.toObject(type: User.self)!
    }
}
