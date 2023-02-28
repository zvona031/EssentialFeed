//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Zvonimir Pavlović on 28.02.2023..
//

import Foundation

struct RemoteFeedItem: Decodable {
    let id: UUID
    let description: String?
    let location: String?
    let image: URL

    init(id: UUID, description: String?, location: String?, image: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.image = image
    }
}
