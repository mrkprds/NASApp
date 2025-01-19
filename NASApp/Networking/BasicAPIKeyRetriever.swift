//
//  BasicAPIKeyRetriever.swift
//  NASApp
//
//  Created by Patrick Perdon on 19/01/2025.
//

import Foundation

/// A basic implementation of APIKeyProvider that returns returns an API Key
struct BasicAPIKeyRetriever: APIKeyProvider {
    
    func getAPIKey() async throws -> String {
        return ""
    }
    
}
