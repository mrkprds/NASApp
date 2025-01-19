//
//  BasicAPIKeyRetriever.swift
//  NASApp
//
//  Created by Patrick Perdon on 19/01/2025.
//

import Foundation

struct BasicAPIKeyRetriever: APIKeyProvider {
    
    func getAPIKey() async throws -> String {
        return ""
    }
    
}
