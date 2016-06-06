//
//  PlanetAPIUITests.swift
//  APIClient
//
//  Created by Kleimaier, Dennis on 30.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import XCTest
import Nimble


class PlanetAPIUITests: XCTestCase {

    private func waitForResponsiveness() {
        let wait = expectationWithDescription("wait")
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            wait.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
        waitForResponsiveness()
    }
    
    
    func testSomeUserInteraction() {
        let app = XCUIApplication()
        
        let searchTextfield = app.textFields["searchField"]
        
        expect(searchTextfield.label).to(beEmpty())
        
        searchTextfield.tap()
        
        searchTextfield.typeText("1\n")
        
        let resultLabel = app.staticTexts["planetName"]
        expect(resultLabel.label).toEventually(equal("Tatooine"), timeout: 10)
    }
    
    
    
}



extension XCUIElement {
    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func clearAndEnterText(text: String) -> Void {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        
        self.tap()
        
        var deleteString: String = ""
        for _ in stringValue.characters {
            deleteString += "\u{8}"
        }
        self.typeText(deleteString)
        
        self.typeText(text)
    }
}