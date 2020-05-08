//
//  GitHubAPI.swift
//  GitHubSearchClient
//
//  Created by 堺雄之介 on 2020/05/08.
//  Copyright © 2020 堺雄之介. All rights reserved.
//

import Foundation

final class GitHubAPI {
    struct SearchRepositories: GitHubRequest {
        typealias Response = ResponseBody<Repository>
        
        let query: String
        
        var path: String {
            return "/search/repositories"
        }
        
        var queryItems: [URLQueryItem] {
            return [URLQueryItem(name: "q", value: query)]
        }
    }
}
