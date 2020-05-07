//
//  GitHubAPIError.swift
//  GitHubSearchClient
//
//  Created by 堺雄之介 on 2020/05/07.
//  Copyright © 2020 堺雄之介. All rights reserved.
//

import Foundation

struct GitHubAPIError: Decodable, Error {
    struct gitHubError: Decodable {
        var resource: String
        var field: String
        var code: String
    }
    
    var message: String
    var errors: [gitHubError]
}
