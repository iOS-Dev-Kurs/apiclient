//
//  APIClientUITests.swift
//  APIClientUITests
//
//  Created by Nils Fischer on 27.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import XCTest
import Nimble


class APIClientUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPokemonSpeciesQueryAndPokedexEntries() {
        let app = XCUIApplication()
        // Enter request in search field
        let searchTextfield = app.textFields["searchTextfield"]
        expect(searchTextfield.label).to(beEmpty())
        searchTextfield.tap()
        searchTextfield.typeText("bulbasaur\n")
        // Expect pokemon species info to be displayed eventually
        let pokemonSpeciesNameLabel = app.staticTexts["pokemonSpeciesName"]
        expect(pokemonSpeciesNameLabel.label).toEventually(equal("Bisasam"), timeout: 10)
        expect(app.images["pokemonSpeciesSprite"].exists).toEventually(beTrue(), timeout: 10)
        // Show pokedex entries
        let showPokedexEntriesButton = app.buttons["showPokedexEntries"]
        expect(showPokedexEntriesButton.exists).toEventually(beTrue(), timeout: 10)
        showPokedexEntriesButton.tap()
        expect(app.cells.count) > 0
        // Select a pokedex entry
        let pokedexEntryCell = app.cells.elementBoundByIndex(0)
        expect(pokedexEntryCell.activityIndicators.element.exists).toEventually(beFalse(), timeout: 10)
        pokedexEntryCell.tap()
        expect(app.cells.count) > 0
        // Select a pokemon species entry in the pokedex
        let pokemonSpeciesCell = app.cells.elementBoundByIndex(0)
        expect(pokemonSpeciesCell.activityIndicators.element.exists).toEventually(beFalse(), timeout: 30)
        let selectedPokemonSpeciesName = pokemonSpeciesCell.staticTexts["pokemonSpeciesName"].label
        pokemonSpeciesCell.tap()
        // Expect the selected pokemon species to be displayed
        expect(pokemonSpeciesNameLabel.label).to(equal(selectedPokemonSpeciesName))
    }
    
}
