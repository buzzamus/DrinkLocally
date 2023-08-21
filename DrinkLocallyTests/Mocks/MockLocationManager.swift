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
    var mockAuthorizationStatus: CLAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
    }
    
    override var location: CLLocation? {
        return mockLocation
    }
    
    func authorizationStatus() -> CLAuthorizationStatus {
        return mockAuthorizationStatus
    }
}
