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
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    
    func testSomeUserInteraction() {
        let app = XCUIApplication()
        
        let searchTextfield = app.textFields["searchField"]
        
        //expect(searchTextfield.label).notTo(beEmpty())
        
        searchTextfield.clearAndEnterText("1")
        
        //let resultLabel = app.staticTexts["planetLab"]
        //expect(resultLabel.label).toEventually(equal("Tatooine"), timeout: 10)
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