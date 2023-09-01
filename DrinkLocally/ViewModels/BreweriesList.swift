//
//  BreweriesList.swift
//  DrinkLocally
//
//  Created by Brent Busby on 8/31/23.
//

import Foundation
import CoreLocation

class BreweriesList: ObservableObject {
    let apiClient: APIClient
    @Published var locationService: LocationService
    @Published var breweries = [Brewery]()
    
    init(locationManager: CLLocationManager, client: APIClient = APIClient()) {
        self.apiClient = client
        self.locationService = LocationService(locationManager: locationManager)
    }
    
    func locationPermissionGiven() -> Bool {
        return locationService.permissionGiven
    }
    
    func setupLocationServices() {
        locationService.retrieveLocation()
    }
    
    @MainActor
    func populateBreweries() async throws {
        guard let url = URL(string: Endpoints.breweriesListBaseURLString + locationString()) else { return }
        self.breweries = try await apiClient.fetchBreweries(url: url)
    }
    
    private func locationString() -> String {
        if let location = locationService.currentLocation {
            return String(location.coordinate.latitude) + "," + String(location.coordinate.longitude)
        } else {
            // TODO: This shouldn't ever be reached even if the user refuses location services, but should handle in a better way
            return "0.000,0.000"
        }
    }
}
