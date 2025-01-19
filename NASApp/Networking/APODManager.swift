//
//  APODManager.swift
//  NASApp
//
//  Created by Patrick Perdon on 19/01/2025.
//

import Foundation

actor APODManager: APIConsumer {
    
    nonisolated let apiKeyProvider: APIKeyProvider = BasicAPIKeyRetriever()
    
    static let shared = APODManager()
    
    private let networkManager = NetworkManager()
    
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
    
    func getApod() async throws -> APOD {
        let url = try await baseURL.url
        return try await networkManager.fetch(url)
    }
}
