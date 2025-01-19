//
//  APIKeyProvider.swift
//  NASApp
//
//  Created by Patrick Perdon on 19/01/2025.
//

import Foundation

/// A protocol that defines a way to retrieve an API key .
/// Implement this protocol to provide different strategies for API key retrieval,
/// such as loading from a secure keychain, remote configuration, or encrypted storage.
protocol APIKeyProvider {
    
    /// Retrieves the API key asynchronously from the underlying storage or service.
    /// - Throws: An error if the API key cannot be retrieved. Implementations should define
    ///           specific error cases for different failure scenarios.
    /// - Returns:  A valid API key as a String.
    func getAPIKey() async throws -> String
}
