//
//  APIKeyProvider.swift
//  NASApp
//
//  Created by Patrick Perdon on 19/01/2025.
//

import Foundation

protocol APIKeyProvider {
    func getAPIKey() async throws -> String
}
