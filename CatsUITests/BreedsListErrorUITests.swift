//
//  BreedsListErrorUITests.swift
//  Cats
//
//  Created by avz on 05/02/25.
//

import XCTest

final class ErrorHandlingUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("--uitesting-error")
        app.launch()
    }

    func testBreedsList_ErrorHandling_ShouldShowErrorView() {
        let errorMessage = app.staticTexts["Unable to load data"]
        XCTAssertTrue(errorMessage.waitForExistence(timeout: 3))

        let retryButton = app.buttons["Try Again"]
        XCTAssertTrue(retryButton.exists)
    }
}
