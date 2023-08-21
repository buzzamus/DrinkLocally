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
    
    func test_locationService_getsCurrentLocationWhenPermissionGiven() {
        let location = CLLocation(latitude: -44.0321, longitude: 81.2435)
        locationManagerMock.mockAuthorizationStatus = .authorizedWhenInUse
        locationManagerMock.mockLocation = location
        
        sut.getLocation()
        
        print("----------------------")
        print(locationManagerMock.location?.coordinate.latitude)
        print(sut.permissionGiven)
        print(sut.currentLocation?.coordinate.latitude)
        
        
        XCTAssertEqual(sut.currentLocation?.coordinate.latitude, location.coordinate.latitude)
    }
}
