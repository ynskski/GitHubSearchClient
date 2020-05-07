//
//  GitHubAPIErrorTests.swift
//  GitHubSearchClientTests
//
//  Created by 堺雄之介 on 2020/05/07.
//  Copyright © 2020 堺雄之介. All rights reserved.
//

import XCTest
@testable import GitHubSearchClient

class GitHubAPIErrorTests: XCTestCase {
    func testDecode() throws {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let data = GitHubAPIError.exampleJson.data(using: .utf8)!
        let error = try decoder.decode(GitHubAPIError.self, from: data)
        let firstError = error.errors.first
        
        XCTAssertEqual(error.message, "Validation Failed")
        XCTAssertEqual(firstError?.resource, "Search")
        XCTAssertEqual(firstError?.field, "q")
        XCTAssertEqual(firstError?.code, "missing")
    }
}
