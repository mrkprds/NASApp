//
//  URLConstants.swift
//  NASApp
//
//  Created by Patrick Perdon on 18/01/2025.
//

import Foundation

enum URLConstants {
    
    enum Scheme {
        static let https = "https"
    }
    
    enum Hosts {
        static let baseURL = "api.nasa.gov"
    }
    
    enum Paths {
        
        enum APOD {
            
            static let path = "/planetary/apod"
            
            enum Query {
                static let apiKey = "api_key"
            }
        }
    }
    
}
