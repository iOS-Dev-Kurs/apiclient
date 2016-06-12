//
//  KanyeRESTUItests.swift
//  kanyeAPIClient
//
//  Created by Arthur Heimbrecht on 11.6.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//
import Foundation

import XCTest
import Nimble


class APIClientUITests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		continueAfterFailure = false
		XCUIApplication().launch()
		waitForResponsiveness()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	func testNavigationThroughEntries() {
		let app = XCUIApplication()
		expect(app.cells.count) > 0
		// Select a pokedex entry
		let albumEntryCell = app.cells.elementBoundByIndex(0)
		//expect(albumEntryCell.activityIndicators.element.exists).toEventually(beFalse(), timeout: 10)
		albumEntryCell.tap()
		expect(app.cells.count) > 0
		let trackEntryCell = app.cells.elementBoundByIndex(0)
		//expect(trackEntryCell.activityIndicators.element.exists).toEventually(beFalse(), timeout: 30)
		//let selectedPokemonSpeciesName = pokemonSpeciesCell.staticTexts["pokemonSpeciesName"].label
		trackEntryCell.tap()
		// Expect the selected pokemon species to be displayed
		let LyricsLabel = app.staticTexts["showLyrics"]
		expect(LyricsLabel.label).toNot(beEmpty())
	}
	
	/// Call after launch for a workaround to the app's initial non-responsiveness
	private func waitForResponsiveness() {
		let wait = expectationWithDescription("wait")
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
			wait.fulfill()
		}
		waitForExpectationsWithTimeout(10, handler: nil)
	}
	
}
