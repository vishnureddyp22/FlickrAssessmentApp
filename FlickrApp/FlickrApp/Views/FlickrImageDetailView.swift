//
//  FlickrImageDetailView.swift
//  FlickrApp
//
//  Created by Vishnu on 20/11/24.
//

import Foundation
import SwiftUI

struct FlickrImageDetailView: View {
    let image: FlickrImageData
    @State private var newDescription : String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    AsyncImageView(urlString: image.media?.imageLink ?? "")
                        .frame(width: 200, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .accessibilityLabel("Thumbnail image of \(image.title ?? "")")
                    
                    Text(image.title ?? "")
                        .font(.title)
                        .accessibilityLabel("\(image.title ?? "")")
                        .padding()
                    
                    Text(newDescription)
                        .font(.body)
                        .accessibilityLabel("\(newDescription)")
                        .padding()
                    
                    Text(image.publishedDate)
                        .font(.body)
                        .accessibilityLabel("\(image.publishedDate)")
                        .padding()
                }
            }
            .onAppear {
                DispatchQueue.main.async {
                    newDescription = image.description?.html2String ?? ""
                }
            }
            .navigationTitle("Image Details")
            .padding()
        }
    }
}
