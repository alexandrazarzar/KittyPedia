//
//  BreedDetailsUITests.swift
//  Cats
//
//  Created by avz on 05/02/25.
//

import XCTest
@testable import Cats

final class BreedDetailsViewUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func getToCompleteBreedDetailsScreen() {
        let breedCell = app.staticTexts["Abyssinian"]
        breedCell.tap()
    }
    
    func testBreedDetails_DisplayedCorrectly() {
        getToCompleteBreedDetailsScreen()
        
        let breedName = app.staticTexts["Abyssinian"]
        let temperament = app.staticTexts["Active, Energetic, Independent, Intelligent, Gentle"]
        
        XCTAssertTrue(breedName.exists, "Breed name is missing.")
        XCTAssertTrue(temperament.exists, "Breed temperament is missing.")
    }
    
    func testBreedDetails_MainInfo_ShouldBeCorrectlyDisplayed() {
        getToCompleteBreedDetailsScreen()

        let origin = app.staticTexts["Egypt"]
        let weight = app.staticTexts["5-8 kg"]
        let lifeSpan = app.staticTexts["9-15 years"]
        
        XCTAssertTrue(origin.exists, "Origin is missing.")
        XCTAssertTrue(weight.exists, "Weight name is missing.")
        XCTAssertTrue(lifeSpan.exists, "Life span name is missing.")
    }
    
    func testBreedDetails_Characteristics_ShouldBeCorrectlyDisplayed() {
        getToCompleteBreedDetailsScreen()
        app.swipeUp()
        
        let characteristicTitles = [
            "Adaptability",
            "Affection Level",
            "Child Friendly",
            "Dog Friendly",
            "Energy Level",
            "Intelligence",
            "Social Needs",
            "Stranger Friendly",
            "Vocalization"
        ]
        
        for title in characteristicTitles {
            let characteristicLabel = app.staticTexts[title]
            XCTAssertTrue(characteristicLabel.exists, "\(title) characteristic is missing.")
        }
    }
    
    func testBreedDetails_BreedImage_ShouldNotShowPlaceHolder() {
        getToCompleteBreedDetailsScreen()
        
        let placeholderImage = app.images["placeHolderImage"]
        XCTAssertFalse(placeholderImage.exists, "Placeholder image should not be visible when an actual breed image is available.")
    }
    
    func testBreedDetails_BreedImage_ShouldShowPlaceHolder() {
        let breedCell = app.staticTexts["Siberian"]
        breedCell.tap()
        
        let placeholderImage = app.images["placeHolderImage"]
        XCTAssertTrue(placeholderImage.exists, "Placeholder image should be visible")
    }
    
    func testBreedDetails_NavigateBackToBreedsLis_ShouldGetBackToInitialScreen() {
        getToCompleteBreedDetailsScreen()
        
        let breedName = app.staticTexts["Abyssinian"]
        XCTAssertTrue(breedName.exists, "Breed details view did not open correctly.")

        app.navigationBars.buttons.firstMatch.tap()
        let headerTitle = app.staticTexts["KittyPedia"]
        XCTAssertTrue(headerTitle.waitForExistence(timeout: 3), "Failed to navigate back to the breeds list.")
    }

}

