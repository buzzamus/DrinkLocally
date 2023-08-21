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
    let location = CLLocation(latitude: -44.0321, longitude: 81.2435)

    override func setUpWithError() throws {
        locationManagerMock = MockLocationManager()
        sut = LocationService(locationManager: locationManagerMock)
    }

    override func tearDownWithError() throws {
        locationManagerMock = nil
    }
    
    func test_locationService_returnsCurrentLocation() {
        locationManagerMock.mockAuthorizationStatus = .authorizedWhenInUse
        locationManagerMock.mockLocation = location
        
        sut.getLocation()
        
        XCTAssertEqual(sut.currentLocation?.coordinate.latitude, location.coordinate.latitude)
        XCTAssertTrue(sut.permissionGiven)
        XCTAssertFalse(sut.locationError)
    }
    
    func test_locationService_handlesWhenLocationAuthorizationNotGiven() {
        locationManagerMock.mockAuthorizationStatus = .denied
        
        sut.getLocation()
        
        XCTAssertNil(sut.currentLocation)
        XCTAssertFalse(sut.permissionGiven)
    }
}
