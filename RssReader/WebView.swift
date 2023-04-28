//
//  WebView.swift
//  RssReader
//
//  Created by id on 4/27/23.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var url: String?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let Url = url {
            if let webUrl = URL(string: Url) {
                let request = URLRequest(url: webUrl)
                uiView.load(request)
            }
        }
    }
}
