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

extension ResponseBody where Item == Repository {
    static var exampleJson: String {
        return """
        {
            "total_count": 172764,
            "incomplete_results": false,
            "items": [
                {
                    "id": 44838949,
                    "full_name": "apple/swift",
                    "html_url": "https://github.com/apple/swift",
                    "description": "The Swift Programming Language"
                },
                {
                    "id": 790019,
                    "full_name": "openstack/swift",
                    "html_url": "https://github.com/openstack/swift",
                    "description": "OpenStack Storage (Swift)"
                },
            ]
        }
        """
    }
}
