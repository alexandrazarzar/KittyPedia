//
//  BreedsListViewModel.swift
//  Cats
//
//  Created by avz on 05/02/25.
//

import XCTest
@testable import Cats

@MainActor
class BreedsListViewModelTests: XCTestCase {
    
    var viewModel: BreedsListViewModel!
    var mockService: MockCatsService!
    
    override func setUp() {
        super.setUp()
        mockService = MockCatsService()
        viewModel = BreedsListViewModel(catsService: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testBreedList_LoadBreeds_ShouldBeSuccessful() async {
        mockService.shouldReturnError = false
        mockService.mockBreeds = [
            BreedResponseExamples.completeBreed
        ]
        
        await viewModel.loadBreeds(byPage: 0)
        
        XCTAssertEqual(viewModel.breeds.count, 1)
        XCTAssertNil(viewModel.errorDescription)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testBreedList_LoadMoreContent_Pagination() async {
        viewModel.breeds = [
            Breed(breedResponse: BreedResponseExamples.missingBreedImage)
        
        ]
        mockService.shouldReturnError = false
        mockService.mockBreeds = [ BreedResponseExamples.completeBreed ]
        
        await viewModel.loadMoreContent()
        
        XCTAssertEqual(viewModel.breeds.count, 2)
        XCTAssertEqual(viewModel.page, 1)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testBreedList_LoadBreeds_ErrorHandling() async {
        mockService.shouldReturnError = true
        
        await viewModel.loadBreeds(byPage: 0)
        
        XCTAssertNotNil(viewModel.errorDescription)
        XCTAssertTrue(viewModel.breeds.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testBreedList_LoadBreedsEmptyResult_SetsWeGotToTheEnd() async {
        mockService.shouldReturnError = false
        mockService.mockBreeds = []
        
        await viewModel.loadBreeds(byPage: 0)
        
        XCTAssertTrue(viewModel.weGotToTheEnd)
        XCTAssertEqual(viewModel.breeds.count, 0)
    }
}

class MockCatsService: CatsServiceProtocol {
    var shouldReturnError = false
    var mockBreeds: [BreedResponse] = []
    
    func fetchBreeds(byPage page: Int) async throws -> [BreedResponse] {
        if shouldReturnError {
            throw NSError(domain: "TestError", code: 0, userInfo: nil)
        }
        return mockBreeds
    }
}
