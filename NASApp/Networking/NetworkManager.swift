//
//  NetworkManager.swift
//  NASApp
//
//  Created by Patrick Perdon on 18/01/2025.
//

import Foundation

actor NetworkManager {
    
    private let session: URLSession
    
    /// Initializes NetworkManager with a cached URLSession configuration
    init() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        self.session = URLSession(configuration: config)
    }
    
    enum NetworkError: Error {
        case invalidURL
        case invalidResponse(Int?)
    }
    
    func fetch<T: Decodable>(_ url: URL?) async throws -> T {
        guard let url else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse(nil)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse(httpResponse.statusCode)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
}
