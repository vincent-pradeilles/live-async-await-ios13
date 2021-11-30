//
//  ActivityIndicator.swift
//  AsyncAwait-iOS13
//
//  Created by Vincent on 30/11/2021.
//

import SwiftUI
import UIKit

struct ActivityIndicator: UIViewRepresentable {

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .large)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}
