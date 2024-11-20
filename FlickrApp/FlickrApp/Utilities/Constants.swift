//
//  Constants.swift
//  FlickrApp
//
//  Created by Vishnu on 19/11/24.
//

import Foundation


struct Constants {
    
    struct Numeric {
        
        static let Eight: Double = 8.0
        static let Ten: Double = 10.0
        static let Three: Double = 3.0
        static let HundredSixty: Double = 160.0
        static let ThreeHundred: Double = 300.0
    }
    
    struct APIServices {
        static let EndPoint = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&"
    }
}
