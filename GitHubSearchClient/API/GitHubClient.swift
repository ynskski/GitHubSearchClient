//
//  GitHubClient.swift
//  GitHubSearchClient
//
//  Created by 堺雄之介 on 2020/05/09.
//  Copyright © 2020 堺雄之介. All rights reserved.
//

import Foundation

final class GitHubClient {
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func send<Request: GitHubRequest>(request: Request, completion: @escaping (Result<Request.Response, GitHubClientError>) -> Void) {
        let urlRequest = request.buildURLRequest()
        
        httpClient.sendRequest(urlRequest) { result in
            switch result {
            case .success(let data, let urlResponse):
                do {
                    let response = try request.response(from: data, urlResponse: urlResponse)
                    completion(.success(response))
                } catch let error as GitHubAPIError {
                    completion(.failure(.apiError(error)))
                } catch {
                    completion(.failure(.responseParseError(error)))
                }
            case .failure(let error):
                completion(.failure(.connetcionError(error)))
            }
        }
    }
}
