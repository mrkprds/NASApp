//
//  APOD.swift
//  NASApp
//
//  Created by Patrick Perdon on 19/01/2025.
//

import Foundation


struct APOD: Decodable {
    
    enum MediaType: String, Decodable {
        case image
        case video
    }
    
    enum CodingKeys: String, CodingKey {
        case date
        case explanation
        case mediaType = "media_type"
        case title
        case url
    }
    
    let date: Date
    let explanation: String
    let mediaType: MediaType
    let title: String
    let url: URL
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode date string using DateFormatter
        let dateString = try container.decode(String.self, forKey: .date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: dateString) else {
            throw DecodingError.dataCorruptedError(
                forKey: .date,
                in: container,
                debugDescription: "Date string does not match format: \(dateString)"
            )
        }
        
        self.date = date
        self.explanation = try container.decode(String.self, forKey: .explanation)
        self.mediaType = try container.decode(MediaType.self, forKey: .mediaType)
        self.title = try container.decode(String.self, forKey: .title)
        self.url = try container.decode(URL.self, forKey: .url)
    }
}
