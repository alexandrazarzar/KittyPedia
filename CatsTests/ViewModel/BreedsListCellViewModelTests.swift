//
//  BreedsListCellViewModelTests.swift
//  Cats
//
//  Created by avz on 05/02/25.
//

import XCTest
@testable import Cats

class BreedsListCellViewModelTests: XCTestCase {
    
    func testViewModel_InitializesCorrectly() {
        let breedResponse = BreedResponseExamples.completeBreed
        let breed = Breed(breedResponse: breedResponse)
        let viewModel = BreedsListCellViewModel(breed: breed)
        
        XCTAssertEqual(viewModel.name, "Siberian")
        XCTAssertEqual(viewModel.temperament, "Playful, Active")
        XCTAssertEqual(viewModel.imageURL?.absoluteString, "https://example.com/image.jpg")
    }
    
    func testDetailsViewModel_BreedHasNoImage_ImageURLShouldBeNil() {
        let breedResponse =  BreedResponseExamples.missingBreedImage
        let breed = Breed(breedResponse: breedResponse)
        let viewModel = BreedsListCellViewModel(breed: breed)
        
        XCTAssertNil(viewModel.imageURL)
    }
}
