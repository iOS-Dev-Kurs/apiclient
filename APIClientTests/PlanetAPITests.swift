//
//  PlanetAPITests.swift
//  APIClient
//
//  Created by Kleimaier, Dennis on 30.05.16.
//  Copyright © 2016 iOS Dev Kurs Universität Heidelberg. All rights reserved.
//

import Foundation
import XCTest
@testable import APIClient
import Nimble
import Freddy
import Moya

class PlantAPITests: XCTestCase{
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDecodingPlanetSampleData(){
        let data = PlanetAPI.planet(NamedResource(name:"Tatooine")).sampleData
        expect(try JSON(data: data)).toNot(throwError())
    }
    
    
}