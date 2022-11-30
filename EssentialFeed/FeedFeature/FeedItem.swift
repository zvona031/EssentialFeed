//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Zvonimir Pavlović on 30.11.2022..
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
