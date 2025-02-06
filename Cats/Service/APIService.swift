//
//  APIService.swift
//  Cats
//
//  Created by avz on 03/02/25.
//

import Foundation

protocol APIServiceProtocol {
    var baseURL: String { get }
    var apiKey: String { get }
    
    func fetchData<T: Decodable>(from endpoint: String, queryItems: [URLQueryItem]) async throws -> T
}

class APIService: APIServiceProtocol {
    let baseURL: String
    let apiKey: String
    private let session: URLSession
    private let jsonDecoder: JSONDecoder
    
    init(baseURL: String,
         apiKey: String,
         session: URLSession = .shared,
         jsonDecoder: JSONDecoder = JSONDecoder())
    {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.session = session
        self.jsonDecoder = jsonDecoder
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func fetchData<T: Decodable>(from endpoint: String, queryItems: [URLQueryItem] = []) async throws -> T {
        var components = URLComponents(string: baseURL)
        components?.path = endpoint
        components?.queryItems = queryItems + [URLQueryItem(name: "api_key", value: apiKey)]
        
        guard let url = components?.url else {
            throw ServiceError.endpointNotFound
        }

        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw ServiceError.invalidResponse
        }

        do {
            return try jsonDecoder.decode(T.self, from: data)
        } catch {
            throw ServiceError.decodingFailure(error.localizedDescription)
        }
    }
}
