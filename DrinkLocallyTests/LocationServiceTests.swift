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
   private var locationManagerMock: MockLocationManager!
    private var sut: LocationService!
    private let location = CLLocation(latitude: 48.858093, longitude: 2.294694)

    override func setUpWithError() throws {
        locationManagerMock = MockLocationManager()
        sut = LocationService(locationManager: locationManagerMock)
    }

    override func tearDownWithError() throws {
        locationManagerMock = nil
        sut = nil
    }
    
    func test_locationService_returnsCurrentLocation() {
        locationManagerMock.mockAuthorizationStatus = .authorizedWhenInUse
        locationManagerMock.mockLocation = location
        
        sut.retrieveLocation()
        
        XCTAssertEqual(sut.currentLocation?.coordinate.latitude, location.coordinate.latitude)
        XCTAssertTrue(sut.permissionGiven)
    }
    
    func test_locationService_handlesWhenLocationAuthorizationNotGiven() {
        locationManagerMock.mockAuthorizationStatus = .denied
        
        sut.retrieveLocation()
        
        XCTAssertNil(sut.currentLocation)
        XCTAssertFalse(sut.permissionGiven)
    }
}
