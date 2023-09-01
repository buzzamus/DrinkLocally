//
//  Location.swift
//  DrinkLocally
//
//  Created by Brent Busby on 8/20/23.
//

import Foundation
import CoreLocation

class LocationService: NSObject, ObservableObject {
    fileprivate var locationManager: CLLocationManager
    @Published private(set) var currentLocation: CLLocation?
    @Published private(set) var locationError = false
    @Published private(set) var permissionGiven = false
    
    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
    }
    
    func retrieveLocation() {
        if permissionGiven == false {
            requestLocationAuthorization()
        }
        setLocation()
    }
    
    private func requestLocationAuthorization() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
    }
    
    private func setLocation() {
        if (locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways) {
            currentLocation = locationManager.location
            permissionGiven = true
        } else {
            permissionGiven = false
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        locationError = true
    }
}
