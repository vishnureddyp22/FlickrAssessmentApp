//
//  FlickrAppTests.swift
//  FlickrAppTests
//
//  Created by Vishnu on 19/11/24.
//

import XCTest
import Combine
@testable import FlickrApp

final class FlickrAppTests: XCTestCase {
    
    var viewModel = FlickrImageListViewModel()
    var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFlickrAPIRequestSuccess() {
            let expectation = XCTestExpectation(description: "Search API Success")
            
            viewModel.$thumbnails
                .dropFirst() // Wait for update
                .sink { thumbnails in
                    XCTAssertFalse(thumbnails.isEmpty)
                    expectation.fulfill()
                }
                .store(in: &cancellables)
            
            viewModel.loadFlickrImages(searchtext: "porcupine")
            wait(for: [expectation], timeout: 1.0)
        }

}
