//
//  WebService.swift
//  FlickrApp
//
//  Created by Vishnu on 19/11/24.
//

import Foundation
import Combine

class WebService {
    static let shared = WebService()
    private let cache = NSCache<NSURL, NSData>()
    
    private init() {}
    
    private var flickrListDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        
        // Define a custom DateFormatter
        let model = DateFormatterModel()
        decoder.dateDecodingStrategy = .formatted(model.isoDateFormatter)
        return decoder
    }()
    
    // Fetch thumbnail images
    func fetchFlickrThumbnails(query: String) -> AnyPublisher<FlickrDataResponse, Error> {
        let endpoint = "\(Constants.APIServices.EndPoint)tags=\(query)"
        guard let url = URL(string: endpoint) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: FlickrDataResponse.self, decoder: flickrListDecoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // Fetch Images with Caching
    func fetchImage(url: URL) -> AnyPublisher<Data, Error> {
        if let cachedData = cache.object(forKey: url as NSURL) as? Data {
            return Just(cachedData)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { [weak self] (data, response) in
                self?.cache.setObject(data as NSData, forKey: url as NSURL)
                return data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
