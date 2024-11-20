//
//  MockWebService.swift
//  FlickrAppTests
//
//  Created by Vishnu on 20/11/24.
//

import Foundation
import Combine
@testable import FlickrApp

class MockWebService: WebService {
  
    override func fetchFlickrThumbnails(query: String) -> AnyPublisher<FlickrDataResponse, Error> {
        guard let bundleURL = Bundle(for: type(of: self)).url(forResource: "FlickrImageResponse", withExtension: "json"),
              let mockData = try? Data.init(contentsOf: bundleURL),
              let modelResponse = try? JSONDecoder().decode(FlickrDataResponse.self, from: mockData)  else {
            fatalError("Json not found")
        }
        
        return Just(modelResponse)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
