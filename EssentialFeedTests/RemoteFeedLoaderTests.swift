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
    let url: URL

    init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }

    func load(completion: @escaping (EssentialFeed.LoadFeedResult) -> Void) {
        client.get(from: url)
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
        let url = URL(string: "www.google.hr")!
        let _ = RemoteFeedLoader(client: client, url: url)

        XCTAssertNil(client.requestedURL)
    }

    func test_init_requestDataFromURL() {
        let client = HTTPClientSpy()
        let url = URL(string: "www.google.hr")!
        let sut = RemoteFeedLoader(client: client, url: url)

        sut.load { _ in }

        XCTAssertEqual(client.requestedURL, url)
    }
}
