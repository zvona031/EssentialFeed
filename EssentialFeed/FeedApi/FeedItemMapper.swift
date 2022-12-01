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

        var feed: [FeedItem] {
            return items.map { $0.feedItem }
        }
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

    private static var OK_200: Int { 200 }
    
    static func map(_ data: Data, from response: HTTPURLResponse) -> RemoteFeedLoader.Result {
        guard response.statusCode == OK_200,
              let root = try? JSONDecoder().decode(Root.self, from: data) else {
            return .failure(RemoteFeedLoader.Error.invalidData)
        }
        
        return .success(root.feed)
    }
}
