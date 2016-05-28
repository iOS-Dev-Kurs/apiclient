//
//  APIClientTests.swift
//  APIClientTests
//
//  Created by Nils Fischer on 27.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import XCTest
@testable import APIClient
import Nimble
import Moya
import Freddy


class PokeAPITests: XCTestCase {

    let pokeAPI = MoyaProvider<PokeAPI>()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDecodingPokemonSpeciesSampleData() {
        self.continueAfterFailure = false
        let data = PokeAPI.pokemonSpecies(NamedResource(name: "bulbasaur")).sampleData
        testDecodingPokemonSpeciesFromData(data)
    }
    
    func testNetworkRequestForPokemonSpecies() {
        let networkExpectation = expectationWithDescription("Network request")
        pokeAPI.request(.pokemonSpecies(NamedResource(name: "bulbasaur"))) { result in
            switch result {
            case .Success(let response):
                guard let pokemonSpecies = self.testDecodingPokemonSpeciesFromData(response.data) else { return }
                expect(pokemonSpecies.name) == "bulbasaur"
            case .Failure(let error):
                fail("Request failed: \(error)")
            }
            networkExpectation.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    private func testDecodingPokemonSpeciesFromData(data: NSData) -> PokemonSpecies? {
        expect(try JSON(data: data)).toNot(throwError())
        guard let json = try? JSON(data: data) else { return nil }
        expect(try PokemonSpecies(json: json)).toNot(throwError())
        guard let pokemonSpecies = try? PokemonSpecies(json: json) else { return nil }
        expect(pokemonSpecies.name).toNot(beEmpty())
        expect(pokemonSpecies.localizedName).toNot(beEmpty())
        expect(pokemonSpecies.flavorText).toNot(beEmpty())
        expect(pokemonSpecies.varieties).toNot(beEmpty())
        return pokemonSpecies
    }
    
}
