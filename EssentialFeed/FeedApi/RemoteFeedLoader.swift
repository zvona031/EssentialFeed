//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Zvonimir Pavlović on 30.11.2022..
//

import Foundation

public final class RemoteFeedLoader {
    private let client: HTTPClient
    private let url: URL

    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }

    public enum Result: Equatable {
        case success([FeedItem])
        case failure(Error)
    }

    public init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }

    public func load(completion: @escaping (Result) -> Void ) {
        client.get(from: url) { result in
            switch result {
            case let .success(data, response):
                completion(self.map(data, from: response))
            case .failure(_):
                completion(.failure(.connectivity))
            }
        }
    }

    private func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let items = try FeedItemsMapper.map(data, response: response)
            return .success(items)
        } catch {
            return .failure(.invalidData)
        }
    }
}
