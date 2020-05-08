//
//  GitHubClientTests.swift
//  GitHubSearchClientTests
//
//  Created by 堺雄之介 on 2020/05/09.
//  Copyright © 2020 堺雄之介. All rights reserved.
//

import XCTest
@testable import GitHubSearchClient

final class GitHubClientTests: XCTestCase {
    private var httpClient: mockHTTPClient!
    private var githubClient: GitHubClient!

    override func setUpWithError() throws {
        super.setUp()
        httpClient = mockHTTPClient()
        githubClient = GitHubClient(httpClient: httpClient)
    }
    
    private func makeHTTPClientResult(statusCode: Int, json: String) -> Result<(Data, HTTPURLResponse), Error> {
        return .success((
            json.data(using: .utf8)!,
            HTTPURLResponse(url: URL(string: "https://api.github.com/search/repositories")!,
                            statusCode: statusCode,
                            httpVersion: nil,
                            headerFields: nil)!
        ))
    }
    
    func testSuccess() {
        httpClient.result = makeHTTPClientResult(statusCode: 200, json:GitHubAPI.SearchRepositories.Response.exampleJson)
        
        let request = GitHubAPI.SearchRepositories(query: "swift")
        let apiExpectation = expectation(description: "")
        githubClient.send(request: request) { result in
            switch result {
            case .success(let response):
                let repository = response.items.first
                XCTAssertEqual(repository?.fullName, "apple/swift")
            default:
                XCTFail("unexpected result: \(result)")
            }
            apiExpectation.fulfill()
        }
        
        wait(for: [apiExpectation], timeout: 3)
    }
    
    func testFailureByConnectionError() {
        httpClient.result = .failure(URLError(.cannotConnectToHost))
        
        let request = GitHubAPI.SearchRepositories(query: "swift")
        let apiExpectation = expectation(description: "")
        githubClient.send(request: request) { result in
            switch result {
            case .failure(.connetcionError):
                break
            default:
                XCTFail("unexpected result: \(result)")
            }
            apiExpectation.fulfill()
        }
        
        wait(for: [apiExpectation], timeout: 3)
    }
    
    func testFailureByResponseParseError() {
        httpClient.result = makeHTTPClientResult(statusCode: 200, json: "{}")
        
        let request = GitHubAPI.SearchRepositories(query: "swift")
        let apiExpectation = expectation(description: "")
        githubClient.send(request: request) { result in
            switch result {
            case .failure(.responseParseError):
                break
            default:
                XCTFail("unexpected result: \(result)")
            }
            apiExpectation.fulfill()
        }
        
        wait(for: [apiExpectation], timeout: 3)
    }
    
    func testFailureByAPIError() {
        httpClient.result = makeHTTPClientResult(statusCode: 400, json: GitHubAPIError.exampleJson)
        
        let request = GitHubAPI.SearchRepositories(query: "swift")
        let apiExpectation = expectation(description: "")
        githubClient.send(request: request) { result in
            switch result {
            case .failure(.apiError):
                break
            default:
                XCTFail("unexpected result: \(result)")
            }
            apiExpectation.fulfill()
        }
        
        wait(for: [apiExpectation], timeout: 3)
    }
}

final class mockHTTPClient: HTTPClient {
    var result: Result<(Data, HTTPURLResponse), Error> = .success((
        Data(),
        HTTPURLResponse(url: URL(string: "https://example.com")!,
                        statusCode: 200,
                        httpVersion: nil,
                        headerFields: nil)!
    ))
    
    func sendRequest(_ urlRequest: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [unowned self] in
            completion(self.result)
        }
    }
}
