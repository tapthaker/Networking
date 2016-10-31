//
//  NetworkingTests.swift
//  NetworkingTests
//
//  Created by Tapan Thaker on 29/10/16.
//  Copyright © 2016 TT. All rights reserved.
//

import XCTest
@testable import Networking

class NetworkingTests: XCTestCase {

    let apiClient = APIClient()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPostSuccess() {
        let postSuccessExpectation = expectation(description: "Post success")
        var response: Either<[String : Any], NetworkError>?
        apiClient.request(url: "https://httpbin.org/post", params: ["foo" : "bar"], method: .post) { (resp) in
            response = resp
            postSuccessExpectation.fulfill()
        }
        self.waitForExpectations(timeout: 5, handler: nil)

        XCTAssertTrue(response?.isLeft() ?? false)

    }

    func testGetSuccess() {
        let getSuccessExpectation = expectation(description: "Get success")
        var response: Either<[String : Any], NetworkError>?
        apiClient.request(url: "https://httpbin.org/get", params: ["foo" : "bar"], method: .get) { (resp) in
            response = resp
            getSuccessExpectation.fulfill()
        }
        self.waitForExpectations(timeout: 5, handler: nil)

        XCTAssertTrue(response?.isLeft() ?? false)
    }
    
}
