//  Created on 07/06/2022.

import UIKit

enum RawImageAsset: String, CaseIterable {
    
    case home = "home"
    case profile = "profile"
    case favourite = "favourite"
    
    func load() -> UIImage? {
        return UIImage(named: self.rawValue)
    }
    
}

struct ImageAsset {
    static func load(_ asset: RawImageAsset) -> UIImage {
        return asset.load()!
    }
}
