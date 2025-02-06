//
//  CatsServiceTests.swift
//  Cats
//
//  Created by avz on 05/02/25.
//

import XCTest
@testable import Cats

class CatsServiceTests: XCTestCase {
    
    var catsService: CatsService!
    var mockAPIService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        catsService = CatsService(apiService: mockAPIService)
    }
    
    override func tearDown() {
        catsService = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    var mockBreed: BreedResponse {
        BreedResponse(id: "id",
                      name: "name",
                      temperament: "temperamente",
                      origin: "origin",
                      lifeSpan: "7 - 8",
                      weight: BreedWeightResponse(imperial: "9 - 10", metric: "9 - 10"),
                      description: "description",
                      adaptability: 1,
                      affectionLevel: 1,
                      childFriendly: 1,
                      dogFriendly: 1,
                      energyLevel: 1,
                      intelligence: 1,
                      socialNeeds: 1,
                      strangerFriendly: 1,
                      vocalisation: 1,
                      image: nil
        )
    }
    
    func testFetchBreeds_Success() async throws {
        mockAPIService.mockBreeds = [
            mockBreed
        ]

        let breeds = try await catsService.fetchBreeds(byPage: 0)
        XCTAssertEqual(breeds.count, 1)
        XCTAssertEqual(breeds[0].name, "name")
    }
    
    func testFetchBreeds_Error() async throws {
        mockAPIService.shouldReturnError = true
        
        do {
            let _ = try await catsService.fetchBreeds(byPage: 0)
            XCTFail("Expected error but succeeded")
        } catch {
            XCTAssertTrue(error is ServiceError)
        }
    }
}
