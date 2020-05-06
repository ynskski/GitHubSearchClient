//
//  ResponseBody.swift
//  GitHubSearchClient
//
//  Created by 堺雄之介 on 2020/05/06.
//  Copyright © 2020 堺雄之介. All rights reserved.
//

import Foundation

struct ResponseBody<Item: Decodable>: Decodable {
    var totalCount: Int
    var items: [Item]
}
