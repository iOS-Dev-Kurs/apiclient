//
//  KanyeRESTtests.swift
//  kanyeAPIClient
//
//  Created by Arthur Heimbrecht on 6.6.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import Nimble
import Moya
import Freddy

import XCTest
// Import the App module with access to all internal types and functions
@testable import kanyeAPIClient
// Nimble provides excellent testing functionality import Nimble
// Every subclass of `XCTestCase` can provide tests class YourAPITests:
class kayeAPItests : XCTestCase {
	
	let kanyeAPI = MoyaProvider<kanyeREST>()
	
	override func setUp() {
		super.setUp()
		// Called before the invocation of each test
	}
	override func tearDown() {
		super.tearDown()
	}

	func testDecodingTrackSampleData() {
		self.continueAfterFailure = false
		let data = kanyeREST.track(title: "ultimate bullshittery").sampleData
		testDecodingTrackFromData(data)
	}
	
	func testDecodingAlbumSampleData() {
		self.continueAfterFailure = false
		let data = kanyeREST.album(title: "ultimate bullshittery albumstyle").sampleData
		testDecodingAlbumFromData(data)
	}
	
	func testNetworkRequestForPokemonSpecies() {
		let networkExpectation = expectationWithDescription("Network request")
		kanyeAPI.request(.track(title: "good_morning")) {
			result in
			switch result {
			case .Success(let response):
				guard let track = self.testDecodingTrackFromData(response.data) else { return }
				expect(track.title) == "good_morning"
			case .Failure(let error):
				fail("Request failed: \(error)")
			}
			networkExpectation.fulfill()
		}
		waitForExpectationsWithTimeout(10, handler: nil)
	}
	
	private func testDecodingTrackFromData(data: NSData) -> Track?	{
		expect(try JSON(data: data)).toNot(throwError())
		guard let json = try? JSON(data: data) else { return nil }
		expect(try Track(json: json)).toNot(throwError())
		guard let track = try? Track(json: json) else { return nil }
		expect(track.title).toNot(beEmpty())
		expect(track.album).toNot(beEmpty())
		expect(track.lyrics).toNot(beEmpty())
		return track
	}
	
	private func testDecodingAlbumFromData(data: NSData) -> Album?	{
		expect(try JSON(data: data)).toNot(throwError())
		guard let json = try? JSON(data: data) else { return nil }
		expect(try json.array("result").map(Track.init)).toNot(throwError())
		guard let tracks = try? json.array("result").map(Track.init) else { return nil }
		expect (try Album(tracksfetched: tracks)).toNot(throwError())
		guard let album = try? Album(tracksfetched: tracks) else { return nil }
		expect(album.name).toNot(beEmpty())
		expect(album.tracks).toNot(beEmpty())
		return album
	}
}
// Called after the invocation of each test