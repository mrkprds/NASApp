//
//  APODManager.swift
//  NASApp
//
//  Created by Patrick Perdon on 19/01/2025.
//

import Foundation

/// Manager responsible for fetching NASA's Astronomy Picture of the Day (APOD).
/// This actor provides thread-safe access to APOD data while handling API authentication
/// and URL construction.
actor APODManager: APIConsumer {
    
    /// Provider for NASA API key authentication
    nonisolated let apiKeyProvider: APIKeyProvider = BasicAPIKeyRetriever()
    
    /// Shared singleton instance of APODManager
    static let shared = APODManager()
    
    /// Network manager instance for making HTTP requests
    private let networkManager = NetworkManager()
    
    /// Constructs the base URL for APOD API requests with authentication
     ///
     /// - Returns: URLComponents configured with the APOD endpoint and API key
     /// - Throws: Errors from API key retrieval
    private var baseURL: URLComponents {
        get async throws {
            var components = URLComponents()
            let apiKey = try await apiKeyProvider.getAPIKey()
            let apiKeyQueryItem = URLQueryItem(
                name: URLConstants.Paths.APOD.Query.apiKey,
                value: apiKey
            )
            
            components.scheme = URLConstants.Scheme.https
            components.host = URLConstants.Hosts.baseURL
            components.path = URLConstants.Paths.APOD.path
            components.queryItems = [apiKeyQueryItem]
            return components
        }
    }
    
    /// Fetches the current Astronomy Picture of the Day
    ///
    /// - Returns: An APOD object containing the astronomy picture data
    /// - Throws:
    ///   - URL construction errors from baseURL
    ///   - NetworkError cases from the network request
    ///   - JSON decoding errors if the response format is invalid
    func getApod() async throws -> APOD {
        let url = try await baseURL.url
        return try await networkManager.fetch(url)
    }
}
