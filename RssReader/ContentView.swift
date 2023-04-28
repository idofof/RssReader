//
//  ContentView.swift
//  RssReader
//
//  Created by id on 4/27/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FeedViewModel()
    @State private var feedURL = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("请输入目标订阅源", text: $feedURL) {
                    viewModel.fetchFeed(url: feedURL)
                }
                .border(Color.black, width: 3)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                List(viewModel.feedItems) { item in
                    NavigationLink(destination: DetailView(url: item.link)) {
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.headline)
                            
                            HStack {
                                Spacer()
                                
                                Text(item.pubDate, style: .date)
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                            }
                        }
                        .onTapGesture {
                            if let url = URL(string: item.link) {
                                DispatchQueue.main.async {
                                    UIApplication.shared.open(url)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("RssReader")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
