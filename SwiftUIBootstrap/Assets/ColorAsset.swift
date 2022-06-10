//  Created on 07/06/2022.

import UIKit

enum RawColorAsset: String, CaseIterable {
    case primary
    case secondary
    case appYellow
    func load() -> UIColor? {
        return UIColor(named: self.rawValue)
    }
}

struct ColorAsset {
    static func load(_ asset: RawColorAsset) -> UIColor {
        return asset.load()!
    }
}
