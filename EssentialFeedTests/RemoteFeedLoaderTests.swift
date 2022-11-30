//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Zvonimir Pavlović on 30.11.2022..
//

import XCTest
@testable import EssentialFeed

class RemoteFeedLoader: FeedLoader{
    let client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }

    func load(completion: @escaping (EssentialFeed.LoadFeedResult) -> Void) {
        client.get(from: URL(string: "www.google.com")!)
    }
}

protocol HTTPClient {
    func get(from url: URL)
}

class HTTPClientSpy: HTTPClient {
    var requestedURL: URL?

    func get(from url: URL) {
        requestedURL = url
    }
}

final class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        let _ = RemoteFeedLoader(client: client)

        XCTAssertNil(client.requestedURL)
    }

    func test_init_requestDataFromURL() {
        let client = HTTPClientSpy()

        let sut = RemoteFeedLoader(client: client)

        sut.load { _ in }

        XCTAssertNotNil(client.requestedURL)
    }
}
