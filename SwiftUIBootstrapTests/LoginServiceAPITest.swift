//
//  LoginServiceAPITest.swift
//  SwiftUIBootstrapTests
//
//  Created by Masroor Elahi on 21/02/2022.
//

import XCTest
import Combine
import Alamofire

@testable import SwiftUIBootstrap

let apiResponseTimeout: Double = 60

class LoginServiceAPITest: XCTestCase {
    var subscriptions: Set<AnyCancellable> = []
    override func setUp() {
        super.setUp()
        subscriptions = []
    }
    func testLoginAPISuccessResponse() async {
        let loginService: LoginServiceClientProtocol = LoginServiceClient()
        let expectation = expectation(description: "Login successful")
        do {
            let response = try await loginService.loginService(request: LoginRequest.mockSuccess)
            XCTAssertTrue(response.user != nil && response.code == 0)
            expectation.fulfill()
        } catch let error {
            XCTFail(error.localizedDescription)
        }
        wait(for: [expectation], timeout: apiResponseTimeout)
    }
    func testLoginAPIEmptyResponse() async {
        let loginService: LoginServiceClientProtocol = LoginServiceClient()
        let expectation = expectation(description: "Login invalid email or password")
        let response = try? await loginService.loginService(request: LoginRequest.mockFailed)
        if response?.user == nil && response?.code != 0 {
            expectation.fulfill()
        } else {
            XCTFail("User returned after login on wrong credentials")
        }
        wait(for: [expectation], timeout: apiResponseTimeout)
    }
}
