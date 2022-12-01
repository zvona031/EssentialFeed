//
//  FeedItemMapper.swift
//  EssentialFeed
//
//  Created by Zvonimir Pavlović on 01.12.2022..
//

import Foundation

class FeedItemsMapper {
    private struct Root: Decodable {
        let items: [Item]
    }

    private struct Item: Decodable {
        public let id: UUID
        public let description: String?
        public let location: String?
        public let image: URL

        var feedItem: FeedItem {
            FeedItem(id: id, description: description, location: location, imageURL: image)
        }
    }

    static func map(_ data: Data, response: HTTPURLResponse) throws -> [FeedItem] {
        guard response.statusCode == 200 else { throw RemoteFeedLoader.Error.invalidData}
        let root = try JSONDecoder().decode(Root.self, from: data)
        return root.items.map({ $0.feedItem })
    }
}
