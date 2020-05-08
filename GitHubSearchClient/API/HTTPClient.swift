//
//  HTTPClient.swift
//  GitHubSearchClient
//
//  Created by 堺雄之介 on 2020/05/09.
//  Copyright © 2020 堺雄之介. All rights reserved.
//

import Foundation

protocol HTTPClient {
    func sendRequest(_ urlRequest: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void)
}

extension URLSession: HTTPClient {
    func sendRequest(_ urlRequest: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) {
        let task = dataTask(with: urlRequest) { data, urlResponse, error in
            switch (data, urlResponse, error) {
            case (_, _, let error?):
                completion(Result.failure(error))
            case (let data?, let urlResponse as HTTPURLResponse, _):
                completion(Result.success((data, urlResponse)))
            default:
                fatalError("invalid response")
            }
        }
        
        task.resume()
    }
}
