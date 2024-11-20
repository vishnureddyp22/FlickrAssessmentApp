//
//  Extensions.swift
//  FlickrApp
//
//  Created by Vishnu on 20/11/24.
//

import Foundation

// Data extensions
extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}

// String extensions
extension String {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}

// FlickrImageData extensions
extension FlickrImageData {
    var publishedDate: String {
        published?.getShortDate() ?? ""
    }
}

// Date extensions
extension Date {
    func getShortDate() -> String {
        let formatterModel = DateFormatterModel()
        return formatterModel.shortDateFormatter.string(from: self)
    }
}
