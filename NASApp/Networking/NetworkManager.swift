//
//  NetworkManager.swift
//  NASApp
//
//  Created by Patrick Perdon on 18/01/2025.
//

import Foundation

/// A thread-safe network manager that handles HTTP requests.
/// `NetworkManager` provides a shared instance for making HTTP requests and decoding JSON responses.
actor NetworkManager {
    
    /// The underlying URLSession configured with caching support
    private let session: URLSession
    
    /// Initializes NetworkManager with a cached URLSession configuration
    init() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        self.session = URLSession(configuration: config)
    }
    
    /// Errors that can occur during network operations
    enum NetworkError: Error {
        /// The provided URL was invalid or nil
        case invalidURL
        
        /// The server returned an unexpected response code
        case invalidResponse(Int?)
    }
    
    /// Fetches and decodes data from a URL
    ///
    /// - Parameters:
    ///   - url: The URL to fetch data from
    /// - Returns: Decoded object of type T
    /// - Throws:
    ///   - `NetworkError.invalidURL` if the URL is nil
    ///   - `NetworkError.invalidResponse` if the response is invalid or status code is not 2xx
    ///   - Decoding errors if the response data doesn't match type T
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
