//
//  DetailView.swift
//  RssReader
//
//  Created by id on 4/27/23.
//

import SwiftUI

struct DetailView: View {
    
    var url: String?
    
    var body: some View {
        WebView(url: url)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://www.apple.com")
    }
}
