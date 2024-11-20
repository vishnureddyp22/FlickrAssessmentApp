//
//  FlickrImageListView.swift
//  FlickrApp
//
//  Created by Vishnu on 19/11/24.
//

import SwiftUI

struct FlickrImageListView: View {
    @ObservedObject private var viewModel = FlickrImageListViewModel()
    
    @State private var selectedImage: FlickrImageData? = nil

    private let columns = [GridItem(.adaptive(minimum: Constants.Numeric.HundredSixty), spacing: 5)] // Adaptive layout
    
    // Configure Grid View
    private var configureGridView: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .center) {
                ForEach(viewModel.thumbnails) { thumbnail in
                    AsyncImageView(urlString: thumbnail.media?.imageLink ?? "")
                        .frame(width: Constants.Numeric.HundredSixty, height: Constants.Numeric.HundredSixty)
                        .background(Color.gray.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .onTapGesture {
                            selectedImage = thumbnail
                        }
                        .accessibilityLabel(thumbnail.title ?? "")
                        .accessibilityHint("Tap to view image details")
                }
            }
            .padding()
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Search field
                SearchBarView(searchText: $viewModel.searchText) {
                    viewModel.loadFlickrImages(searchtext: viewModel.searchText)
                }
                
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .accessibilityIdentifier("Loading Indicator")
                    Spacer()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage).foregroundColor(.red)
                        .accessibilityIdentifier("Error Message")
                } else {
                    // Scroll view
                    configureGridView
                }
            }
            .sheet(item: $selectedImage) { imageData in
                FlickrImageDetailView(image: imageData)
            }
            .navigationTitle("Flickr")
        }
        
    }
}

struct FlickrImageListView_Previews: PreviewProvider {
    static var previews: some View {
        FlickrImageListView()
    }
}
