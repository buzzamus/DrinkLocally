//
//  LocationManagerMock.swift
//  DrinkLocallyTests
//
//  Created by Brent Busby on 8/20/23.
//

import Foundation
import CoreLocation

class MockLocationManager: CLLocationManager {
    var mockLocation: CLLocation?
    var mockAuthorizationStatus: CLAuthorizationStatus = .authorizedWhenInUse
    
    override init() {
        super.init()
    }
    
    override var location: CLLocation? {
        return mockLocation
    }
    
    override var authorizationStatus: CLAuthorizationStatus {
        return mockAuthorizationStatus
    }
}
