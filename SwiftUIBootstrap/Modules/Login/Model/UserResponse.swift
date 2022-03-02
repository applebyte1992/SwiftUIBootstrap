import Foundation
class UserResponse: Codable {
	let user: User?
	let support: Support?

	enum CodingKeys: String, CodingKey {
		case user = "data"
		case support
	}

    init(user: User? , support: Support?) {
        self.user = user
        self.support = support
    }
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		user = try values.decodeIfPresent(User.self, forKey: .user)
		support = try values.decodeIfPresent(Support.self, forKey: .support)
	}

}

extension UserResponse {
     static var mock: UserResponse {
        return UserResponse(user: User.mock, support: nil)
    }
}
