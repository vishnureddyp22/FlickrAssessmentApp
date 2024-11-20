//
//  ImageLoader.swift
//  FlickrApp
//
//  Created by Vishnu on 20/11/24.
//

import Foundation
import UIKit
import Combine

// MARK: - ImageLoader
class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading = false
    
    private let urlString: String
    private var cancellables = Set<AnyCancellable>()
    
    init(urlString: String) {
        self.urlString = urlString
        loadImage()
    }
    
    private func loadImage() {
        guard let url = URL(string: urlString) else { return }
        isLoading = true
        
        WebService.shared.fetchImage(url: url)
            .compactMap { UIImage(data: $0) }
            .sink { [weak self] completion in
                self?.isLoading = false
            } receiveValue: { [weak self] image in
                self?.image = image
            }
            .store(in: &cancellables)
    }
}
