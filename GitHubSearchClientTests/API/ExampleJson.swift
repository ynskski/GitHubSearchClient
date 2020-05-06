//
//  ExampleJson.swift
//  GitHubSearchClientTests
//
//  Created by 堺雄之介 on 2020/05/06.
//  Copyright © 2020 堺雄之介. All rights reserved.
//

import Foundation
@testable import GitHubSearchClient

extension Repository {
    static var exampleJson: String {
        return """
        {
            "id": 44838949,
            "full_name": "apple/swift",
            "html_url": "https://github.com/apple/swift",
            "description": "The Swift Programming Language"
        }
        """
    }
}
