//
//  Location.swift
//  DrinkLocally
//
//  Created by Brent Busby on 8/20/23.
//

import Foundation
import CoreLocation
import Combine

class LocationService: NSObject, ObservableObject {
    @Published var locationManager: CLLocationManager
    @Published private(set) var currentLocation: CLLocation?
    @Published private(set) var permissionGiven = false
    
    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
        self.retrieveLocation()
    }
    
    func retrieveLocation() {
        if permissionGiven == false {
            requestLocationAuthorization()
        }
        setLocation()
    }
    
    private func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func setLocation() {
        if (locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways) {
            permissionGiven = true
        } else {
            permissionGiven = false
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard .authorizedWhenInUse == manager.authorizationStatus else { return }
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
