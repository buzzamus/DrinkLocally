//
//  LocationServiceTests.swift
//  DrinkLocallyTests
//
//  Created by Brent Busby on 8/20/23.
//

import XCTest
import CoreLocation
@testable import DrinkLocally

final class LocationServiceTests: XCTestCase {
    var locationManagerMock: MockLocationManager!
    var sut: LocationService!

    override func setUpWithError() throws {
        locationManagerMock = MockLocationManager()
        sut = LocationService(locationManager: locationManagerMock)
    }

    override func tearDownWithError() throws {
        locationManagerMock = nil
    }
    
    func test_locationService_returnsCurrentLocation() {
        XCUIDevice.shared.location = XCUILocation(location: CLLocation(latitude: 37.334886, longitude: -122.008988))
        let location = CLLocation(latitude: -44.0321, longitude: 81.2435)
        locationManagerMock.mockAuthorizationStatus = .authorizedWhenInUse
        locationManagerMock.mockLocation = location
        let completionExpectation = expectation(description: "Completion expectation")
        
        sut.getLocation()
        completionExpectation.fulfill()
        
        wait(for: [completionExpectation], timeout: 1)
        XCTAssertEqual(sut.currentLocation?.coordinate.latitude, location.coordinate.latitude)
    }
}
