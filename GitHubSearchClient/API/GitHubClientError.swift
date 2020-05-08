//
//  GitHubClientError.swift
//  GitHubSearchClient
//
//  Created by 堺雄之介 on 2020/05/07.
//  Copyright © 2020 堺雄之介. All rights reserved.
//

import Foundation

enum GitHubClientError: Error {
    case connetcionError(Error)
    case responseParseError(Error)
    case apiError(GitHubAPIError)
}
