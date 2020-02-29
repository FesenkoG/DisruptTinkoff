//
//  KeychainAuthenticationServiceTests.swift
//  Authentication-Unit-Tests
//
//  Created by Georgy Fesenko on 24/02/2020.
//

import XCTest
@testable import AuthDev
import KeychainAccess

class KeychainAuthenticationServiceTests: XCTestCase {
    var service: KeychainAuthenticationService!

    override func setUp() {
        super.setUp()
        service = KeychainAuthenticationService()
    }

    override func tearDown() {
        super.tearDown()
        service.clear()
    }

    func test_array_to_string_converts_correctly() {
        let result = service.convertArrayToString([1, 2, 4, 2])

        XCTAssertEqual(result, "1242")
    }
}
