//
//  FlickrDataResponse.swift
//  FlickrApp
//
//  Created by Vishnu on 20/11/24.
//

import Foundation

// MARK: - FlickrDataResponse
struct FlickrDataResponse: Codable {
    let title: String?
    let link: String?
    let description: String?
    let modified: Date?
    let generator: String?
    let items: [FlickrImageData]?
}

