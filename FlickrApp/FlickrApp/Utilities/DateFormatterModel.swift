//
//  DateFormatterModel.swift
//  FlickrApp
//
//  Created by Vishnu on 20/11/24.
//

import Foundation

struct DateFormatterModel {
    
    var shortDateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    var isoDateFormatter: DateFormatter = {
        // Define a custom DateFormatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }()
}
