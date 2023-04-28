//
//  FeedItem.swift
//  RssReader
//
//  Created by id on 4/27/23.
//

import Foundation

struct FeedItem: Identifiable {
    let id = UUID()
    let title: String
    let link: String
    let pubDate: Date
}

