//
//  FlickrImageListViewModel.swift
//  FlickrApp
//
//  Created by Vishnu on 19/11/24.
//

import Foundation
import Combine

final class FlickrImageListViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var thumbnails: [FlickrImageData] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let webService = WebService.shared
    
    var thumbailImages: [String] = ["buff-wings", "chicken-pos", "chicken-wings"]
    
    init() {
       // addSearchFieldListener()
    }
    
    private func addSearchFieldListener() {
        $searchText
            .debounce(for: .milliseconds(Int(Constants.Numeric.ThreeHundred)), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] inputText in
                self?.loadFlickrImages(searchtext: inputText)
            }
            .store(in: &cancellables)
    }
    
    func loadFlickrImages(searchtext: String) {
        guard !searchtext.isEmpty else {
            return
        }
        isLoading = true
        errorMessage = nil
        webService.fetchFlickrThumbnails(query: searchtext)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] list in
                self?.thumbnails = list.items ?? []
            }
            .store(in: &cancellables)
    }
}
