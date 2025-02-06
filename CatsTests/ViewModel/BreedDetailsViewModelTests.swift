//
//  BreedDetailsViewModelTests.swift
//  Cats
//
//  Created by avz on 05/02/25.
//

import XCTest
@testable import Cats

class BreedDetailsViewModelTests: XCTestCase {
    
    func completeBreedViewModel() -> BreedDetailsViewModel {
        let breedResponse = BreedResponseExamples.completeBreed
        let breed = Breed(breedResponse: breedResponse)
        return BreedDetailsViewModel(breed: breed)
    }

    func testDetailsViewModel_InitializesCorrectly() {
        let viewModel = completeBreedViewModel()
        
        XCTAssertEqual(viewModel.origin, "Russia")
        XCTAssertEqual(viewModel.lifeSpan, "12-15 years")
        XCTAssertEqual(viewModel.metricWeight, "5-8 kg")
        XCTAssertEqual(viewModel.imperialWeight, "11-17 lb")
        XCTAssertEqual(viewModel.imageURL?.absoluteString, "https://example.com/image.jpg")
    }
    
    func testDetailsViewModel_CharacteristicsCorrectlyLoaded() {
        let viewModel = completeBreedViewModel()

        let expectedCharacteristics = [
            ("Adaptability", 5),
            ("Affection Level", 5),
            ("Child Friendly", 5),
            ("Dog Friendly", 4),
            ("Energy Level", 4),
            ("Intelligence", 5),
            ("Social Needs", 4),
            ("Stranger Friendly", 4),
            ("Vocalization", 3)
        ]
        
        XCTAssertEqual(viewModel.characteristics.count, expectedCharacteristics.count)
        for (index, characteristic) in viewModel.characteristics.enumerated() {
            XCTAssertEqual(characteristic.title, expectedCharacteristics[index].0)
            XCTAssertEqual(characteristic.level, expectedCharacteristics[index].1)
        }
    }
    
    func testDetailsViewModel_WeightOriginAndLifespan() {
        let viewModel = completeBreedViewModel()

         XCTAssertEqual(viewModel.origin, "Russia", "The origin is not as expected.")
         XCTAssertEqual(viewModel.lifeSpan, "12-15 years", "The lifespan is not as expected.")
         XCTAssertEqual(viewModel.metricWeight, "5-8 kg", "The metric weight is not as expected.")
         XCTAssertEqual(viewModel.imperialWeight, "11-17 lb", "The imperial weight is not as expected.")
     }
    
    func testDetailsViewModel_BreedHasNoImage_ImageURLShouldBeNil() {
        let breedResponse = BreedResponseExamples.missingBreedImage
        let breed = Breed(breedResponse: breedResponse)
        let viewModel = BreedDetailsViewModel(breed: breed)

        XCTAssertNil(viewModel.imageURL)
    }
}

