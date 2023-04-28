//
//  FeedViewModel.swift
//  RssReader
//
//  Created by id on 4/27/23.
//

import Foundation
import Combine
import AEXML


class FeedViewModel: ObservableObject {
    @Published var feedItems: [FeedItem] = []
    private var cancellable: Set<AnyCancellable> = []
    
    func fetchFeed(url: String) {
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .tryMap { data in
                try AEXMLDocument(xml: data)
            }
            .map { document in
                document.root["channel"]["item"].all?
                    .compactMap { itemElement in
                        let title = itemElement["title"].value ?? ""
                        let link = itemElement["link"].value ?? ""
                        let pubDateString = itemElement["pubDate"].value ?? ""
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
                        let pubDate = dateFormatter.date(from: pubDateString) ?? Date()
                        return FeedItem(title: title, link: link, pubDate: pubDate)
                    } ?? []
            }
            .receive(on: DispatchQueue.main)
            .sink { completetion in
                switch completetion {
                case .failure(let error):
                    print("error fetching feed: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { document in
                self.feedItems = document
            }
            .store(in: &cancellable)
    }
}
