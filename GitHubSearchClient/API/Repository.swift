//
//  Repository.swift
//  GitHubSearchClient
//
//  Created by 堺雄之介 on 2020/05/06.
//  Copyright © 2020 堺雄之介. All rights reserved.
//

import Foundation

struct Repository: Decodable {
    var id: Int
    var fullName: String
    var htmlUrl: String
    var description: String?
}
