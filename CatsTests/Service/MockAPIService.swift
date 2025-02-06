//
//  MockAPIService.swift
//  Cats
//
//  Created by avz on 06/02/25.
//

import XCTest
@testable import Cats

class MockAPIService: APIServiceProtocol {
    var mockBreeds: [BreedResponse] = []
    var shouldReturnError = false
    
    var baseURL: String = "https://api.example.com"
    var apiKey: String = "test_api_key"
    
    func fetchData<T>(from endpoint: String, queryItems: [URLQueryItem]) async throws -> T where T : Decodable {
        if shouldReturnError {
            throw ServiceError.apiFailure("Mock API error")
        }
        
        if T.self == [BreedResponse].self {
            return mockBreeds as! T
        }
        
        throw ServiceError.decodingFailure("Mock decoding error")
    }
}
