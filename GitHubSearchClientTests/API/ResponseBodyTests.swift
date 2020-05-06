//
//  ResponseBodyTests.swift
//  GitHubSearchClientTests
//
//  Created by 堺雄之介 on 2020/05/06.
//  Copyright © 2020 堺雄之介. All rights reserved.
//

import XCTest
@testable import GitHubSearchClient

final class ResponseBodyTests: XCTestCase {
    func testDecode() throws {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let data = ResponseBody<Repository>.exampleJson.data(using: .utf8)!
        let response = try decoder.decode(ResponseBody<Repository>.self, from: data)
        let firstRepository = response.items.first
        
        XCTAssertEqual(response.totalCount, 172764)
        XCTAssertEqual(response.items.count, 2)
        XCTAssertEqual(firstRepository?.id, 44838949)
        XCTAssertEqual(firstRepository?.fullName, "apple/swift")
        XCTAssertEqual(firstRepository?.htmlUrl, "https://github.com/apple/swift")
        XCTAssertEqual(firstRepository?.description, "The Swift Programming Language")
    }
}
