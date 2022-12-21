//  Created on 07/06/2022.

import UIKit

enum RawImageAsset: String, CaseIterable {
    case home
    case profile
    case favourite
    func load() -> UIImage? {
        return UIImage(named: self.rawValue)
    }
}

struct ImageAsset {
    static func load(_ asset: RawImageAsset) -> UIImage {
        return asset.load()!
    }
}
