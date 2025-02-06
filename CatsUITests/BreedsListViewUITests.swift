//
//  BreedsListViewUITests.swift.swift
//  Cats
//
//  Created by avz on 05/02/25.
//

import XCTest

final class BreedsListViewUITests: XCTestCase {
    
    var app: XCUIApplication!
    var breedCount: Int = 0
    
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
    
    func testBreedsList_HeaderIsDisplayed() {
        let headerTitle = app.staticTexts["KittyPedia"]
        let headerDescription = app.staticTexts["GET TO KNOW CAT BREEDS"]
        XCTAssertTrue(headerTitle.exists, "Header should be visible")
        XCTAssertTrue(headerDescription.exists, "Header should be visible")
    }
    
    func testBreedsList_BreedsListAppearsAfterDataIsLoaded() {
        let listCells = app.cells
        self.breedCount = listCells.count
        XCTAssertTrue(self.breedCount > 0, "Could not load cells")
    }
    
    func testBreedsList_DisplaysCorrectData() {
        let firstBreed = app.staticTexts["Siberian"]
        let secondBreed = app.staticTexts["Abyssinian"]
        
        XCTAssertTrue(firstBreed.waitForExistence(timeout: 3))
        XCTAssertTrue(secondBreed.exists)
    }
    
    func testBreedsList_NavigationToDetailsView_ShouldBeSuccessful() {
        let breedCell = app.staticTexts["Siberian"]
        XCTAssertTrue(breedCell.waitForExistence(timeout: 3))
        
        breedCell.tap()
        
        let breedName = app.staticTexts["Siberian"]
        let breedTemperament = app.staticTexts["Playful, Active"]
        
        XCTAssertTrue(breedName.exists)
        XCTAssertTrue(breedTemperament.exists)
    }
    
    func testBreedsList_LoadMoreButton_MoreBreedShouldBeDisplayed() {
        app.swipeUp()
        let loadMoreButton = app.buttons["LoadMoreButton"]
        XCTAssertTrue(loadMoreButton.waitForExistence(timeout: 3), "Load More button should appear after data is loaded")
        
        loadMoreButton.tap()
        let breedName = app.staticTexts["American Bobtail"]
        XCTAssertTrue(breedName.exists)
    }
    
    func testBreedsList_AllBreedsDisplayed_WeGotToTheEndViewShouldBeDisplayed() {
        app.swipeUp()
        let loadMoreButton = app.buttons["LoadMoreButton"]
        loadMoreButton.tap()
        
        app.swipeUp()
        loadMoreButton.tap()

        let endOfList = app.staticTexts["We got to the end!"]
        XCTAssertTrue(endOfList.exists)
    }
}
