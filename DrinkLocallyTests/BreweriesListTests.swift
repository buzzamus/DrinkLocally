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
    private let location = CLLocation(latitude: 48.858093, longitude: 2.294694)

    override func setUpWithError() throws {
        locationManager = MockLocationManager()
        sut = BreweriesList(locationManager: locationManager)
    }

    override func tearDownWithError() throws {
        locationManager = nil
        sut = nil
    }
    
    func test_BreweriesListGetsLocationAuthorization() {
        locationManager.mockLocation = location
        locationManager.mockAuthorizationStatus = .authorizedWhenInUse
        
        sut.setupLocationServices()
        
        let expectedCoordinates = sut.locationService.currentLocation?.coordinate
        
        XCTAssertTrue(sut.locationPermissionGiven())
        XCTAssertEqual(expectedCoordinates?.latitude, location.coordinate.latitude)
        XCTAssertEqual(expectedCoordinates?.longitude, location.coordinate.longitude)
    }
}
