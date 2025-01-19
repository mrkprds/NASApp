//
//  APIConsumer.swift
//  NASApp
//
//  Created by Patrick Perdon on 19/01/2025.
//

import Foundation

/// A protocol for types that requires API key for making network requests.
/// Conforming types must have access to an APIKeyProvider to securely retrieve
/// API keys for authentication.
protocol APIConsumer {
    /// The provider responsible for secure API key retrieval.
    var apiKeyProvider: APIKeyProvider { get }
}
