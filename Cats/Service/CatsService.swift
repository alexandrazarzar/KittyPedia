//
//  MovieService.swift
//  Cats
//
//  Created by avz on 03/02/25.
//

import Foundation

protocol CatsServiceProtocol {
    func fetchBreeds(byPage page: Int) async throws -> [BreedResponse]
}

class CatsService: CatsServiceProtocol {
    static var shared: CatsServiceProtocol = CatsService()
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService(baseURL: Config.shared.baseURL,
                                                     apiKey: Config.shared.apiKey))
    {
        self.apiService = apiService
    }
    
    func fetchBreeds(byPage page: Int) async throws -> [BreedResponse] {
        let queryItems = [
            URLQueryItem(name: "limit", value: "5"),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        return try await apiService.fetchData(from: "/v1/breeds", queryItems: queryItems)
    }
}

