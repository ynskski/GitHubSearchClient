//
//  GitHubRequest.swift
//  GitHubSearchClient
//
//  Created by 堺雄之介 on 2020/05/07.
//  Copyright © 2020 堺雄之介. All rights reserved.
//

import Foundation

protocol GitHubRequest {
    associatedtype Response: Decodable
    
    var baseUrl: URL { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension GitHubRequest {
    var baseUrl: URL {
        return URL(string: "https://api.github.com")!
    }
    
    func buildURLRequest() -> URLRequest {
        let url = baseUrl.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems
        
        let urlRequest = URLRequest(url: components?.url ?? url)
        return urlRequest
    }
    
    func response(from data: Data, urlResponse: HTTPURLResponse) throws -> Response {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        if (200..<300).contains(urlResponse.statusCode) {
            return try decoder.decode(Response.self, from: data)
        } else {
            throw try decoder.decode(GitHubAPIError.self, from: data)
        }
    }
        
}
