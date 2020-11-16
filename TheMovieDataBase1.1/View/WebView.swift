//
//  WebView.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 8/10/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import UIKit
import AVFoundation
import ARKit
import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    let request: URLRequest

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
}
