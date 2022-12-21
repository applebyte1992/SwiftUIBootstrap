//  Created on 07/06/2022.

import XCTest

@testable import SwiftUIBootstrap

class RawColorAssetTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testRawColorsExist() {
        RawColorAsset.allCases.forEach { (asset) in
            let color = asset.load()
            XCTAssertNotNil(color, "Failed to load color: \(asset.rawValue)")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
