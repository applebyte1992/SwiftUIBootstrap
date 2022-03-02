import Foundation
import RealmSwift

class User: Object,Codable {
    @Persisted var id: Int?
    @Persisted var email: String?
    @Persisted var firstName: String?
    @Persisted var lastName: String?
    @Persisted var  avatar: String?

	enum CodingKeys: String, CodingKey {
		case id
		case email
		case firstName = "first_name"
		case lastName = "last_name"
		case avatar
	}
    override init() { }

    required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
		lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
		avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
	}

}
extension User {
    static var mock: User {
        let user = User()
        user.id = 102
        user.email = "masroor@gmail.com"
        user.firstName = "Masroor"
        user.lastName = "Elahi"
        user.avatar = "blank:page"
        return user
    }
}
