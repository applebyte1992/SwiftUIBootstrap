//  Created on 09/06/2022.

import XCTest

@testable import SwiftUIBootstrap

class RawImageAssetTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testImagesLoad() {
        RawImageAsset.allCases.forEach { (asset) in
            let image = asset.load()
            if image == nil {
                XCTFail("Unable to load asset: \(asset.rawValue)")
            }
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
