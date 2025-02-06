//
//  MockFailingCatsService.swift
//  Cats
//
//  Created by avz on 05/02/25.
//

import Foundation

class MockFailingCatsService: CatsServiceProtocol {
    func fetchBreeds(byPage page: Int) async throws -> [BreedResponse] {
        throw ServiceError.apiFailure("Mock API error")
    }
}

