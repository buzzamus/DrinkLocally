//
//  BreweriesListTests.swift
//  DrinkLocallyTests
//
//  Created by Brent Busby on 9/1/23.
//

import XCTest
@testable import DrinkLocally
import CoreLocation

final class BreweriesListTests: XCTestCase {
    var sut: BreweriesList!
    var locationManager: MockLocationManager!
    var mockAPIClient: MockAPIClient!
    private let location = CLLocation(latitude: 48.858093, longitude: 2.294694)
    private let expectedId = "ef970757-fe42-416f-931d-722451f1f59c"
    private let expectedName = "10 Barrel Brewing Co"
    private let expectedState = "California"

    override func setUpWithError() throws {
        locationManager = MockLocationManager()
        mockAPIClient = MockAPIClient()
        sut = BreweriesList(locationManager: locationManager, apiClient: mockAPIClient)
    }

    override func tearDownWithError() throws {
        locationManager = nil
        mockAPIClient = nil
        sut = nil
    }
    
    func testPopulateBreweries() async throws {
        try await sut.populateBreweries()
        
        XCTAssertEqual(sut.breweries[0].name, expectedName)
        XCTAssertEqual(sut.breweries[0].id, expectedId)
        XCTAssertEqual(sut.breweries[0].stateProvince, expectedState)
    }
    
    func testPopulateSelectedBrewery() async throws {
        
        XCTAssertNil(sut.selectedBrewery)
        
        try await sut.populateSelectedBrewery(breweryId: "ef970757-fe42-416f-931d-722451f1f59c")
        
        XCTAssertEqual(sut.selectedBrewery?.name, expectedName)
        XCTAssertEqual(sut.selectedBrewery?.id, expectedId)
        XCTAssertEqual(sut.selectedBrewery?.stateProvince, expectedState)
    }
}
