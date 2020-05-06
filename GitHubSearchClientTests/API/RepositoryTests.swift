//
//  RepositoryTests.swift
//  GitHubSearchClientTests
//
//  Created by 堺雄之介 on 2020/05/06.
//  Copyright © 2020 堺雄之介. All rights reserved.
//

import XCTest
@testable import GitHubSearchClient

final class RepositoryTests: XCTestCase {
    func testDecode() throws {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let data = Repository.exampleJson.data(using: .utf8)!
        let repository = try decoder.decode(Repository.self, from: data)
        
        XCTAssertEqual(repository.id, 44838949)
        XCTAssertEqual(repository.fullName, "apple/swift")
        XCTAssertEqual(repository.htmlUrl, "https://github.com/apple/swift")
        XCTAssertEqual(repository.description, "The Swift Programming Language")
    }
}
