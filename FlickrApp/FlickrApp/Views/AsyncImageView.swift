//
//  AsyncImageView.swift
//  FlickrApp
//
//  Created by Vishnu on 20/11/24.
//

import SwiftUI
import Combine

struct AsyncImageView: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Image
    
    init(urlString: String, placeholder: Image = Image(systemName: "photo")) {
        _loader = StateObject(wrappedValue: ImageLoader(urlString: urlString))
        self.placeholder = placeholder
    }
    
    var body: some View {
        if let image = loader.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        } else if loader.isLoading {
            ProgressView()
        } else {
            placeholder
                .resizable()
                .scaledToFill()
        }
    }
}
