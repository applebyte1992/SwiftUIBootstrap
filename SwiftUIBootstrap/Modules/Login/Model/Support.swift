
import Foundation
import RealmSwift

class Support : Codable {
	var url : String?
    var text : String?

	enum CodingKeys: String, CodingKey {
		case url
		case text
	}
 
    required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		text = try values.decodeIfPresent(String.self, forKey: .text)
	}

}
