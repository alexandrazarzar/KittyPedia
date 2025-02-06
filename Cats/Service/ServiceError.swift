//
//  ServiceError.swift
//  Cats
//
//  Created by avz on 03/02/25.
//

import Foundation

enum ServiceError: Error {
    case endpointNotFound
    case apiFailure(String)
    case invalidResponse
    case decodingFailure(String)
    
    var description: String {
        switch self {
        case .endpointNotFound:
            return "Endpoint not found"
        case .apiFailure(let message):
            return "API error: \(message)"
        case .invalidResponse:
            return "Invalid response from server"
        case .decodingFailure(let message):
            return "Decoding error: \(message)"
        }
    }
}
