//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Zvonimir Pavlović on 30.11.2022..
//

import XCTest
import EssentialFeed

final class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()

        XCTAssertTrue(client.requestedURLs.isEmpty)
    }

    func test_load_requestsDataFromURL() {
        let url = URL(string: "www.yahoo.com")!
        let (sut, client) = makeSUT(url: url)

        sut.load()

        XCTAssertEqual(client.requestedURLs, [url])
    }

    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(string: "www.yahoo.com")!
        let (sut, client) = makeSUT(url: url)

        sut.load()
        sut.load()

        XCTAssertEqual(client.requestedURLs, [url, url])
    }

    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()

        let clientError = NSError(domain: "Test", code: 0)

        var capturedError = [RemoteFeedLoader.Error]()
        sut.load { capturedError.append($0) }

        client.complete(with: clientError)

        XCTAssertEqual(capturedError, [.connectivity])
    }

    private func makeSUT(url: URL = URL(string: "www.google.hr")!) -> (RemoteFeedLoader, HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(client: client, url: url)
        return (sut, client)

    }

    private class HTTPClientSpy: HTTPClient {
        var requestedURLs: [URL] = []
        var completions = [(Error) -> Void]()

        func get(from url: URL, completion: @escaping (Error) -> Void) {
            requestedURLs.append(url)
            completions.append(completion)
        }

        func complete(with error: Error, at index: Int = 0) {
            completions[index](error)
        }
    }
}
