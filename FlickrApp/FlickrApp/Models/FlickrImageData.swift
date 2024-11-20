//
//  FlickrImageData.swift
//  FlickrApp
//
//  Created by Vishnu on 20/11/24.
//

import Foundation

// MARK: - FlickrImageData
struct FlickrImageData: Identifiable, Codable {
    var id = UUID()
    let title: String?
    let link: String?
    let media: Media?
    let dateTaken: Date?
    let description: String?
    let published: Date?
    let author: Author?
    let authorID: AuthorID?
    let tags: String?

    enum CodingKeys: String, CodingKey {
        case title
        case link
        case media
        case dateTaken = "date_taken"
        case description
        case published
        case author
        case authorID = "author_id"
        case tags
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        link = try container.decode(String.self, forKey: .link)
        media = try container.decode(Media.self, forKey: .media)
        dateTaken = try container.decode(Date.self, forKey: .dateTaken)
        description = try container.decode(String.self, forKey: .description)
        published = try container.decode(Date.self, forKey: .published)
        tags = try container.decode(String.self, forKey: .tags)
        
        let authorName = try? container.decodeIfPresent(Author.self, forKey: .author)
        if let authorName = authorName {
            author = authorName
        } else {
            author = nil
        }
        
        let authorIDObject = try? container.decodeIfPresent(AuthorID.self, forKey: .authorID)
        if let authorIDObject = authorIDObject {
            authorID = authorIDObject
        } else {
            authorID = nil
        }
    }
}

enum Author: String, Codable {
    case nobodyFlickrCOMDavidSchenfeld = "nobody@flickr.com (\"David Schenfeld\")"
    case nobodyFlickrCOMJoelogon = "nobody@flickr.com (\"joelogon\")"
    case nobodyFlickrCOMJohnHallamImages = "nobody@flickr.com (\"John Hallam Images\")"
    case nobodyFlickrCOMPaulCottis = "nobody@flickr.com (\"Paul Cottis\")"
}

enum AuthorID: String, Codable {
    case the17528760N00 = "17528760@N00"
    case the49313793N06 = "49313793@N06"
    case the77017456N03 = "77017456@N03"
    case the87957708N00 = "87957708@N00"
}

// MARK: - Media
struct Media: Codable {
    let imageLink: String?
    
    enum CodingKeys: String, CodingKey {
        case imageLink = "m"
    }
}
