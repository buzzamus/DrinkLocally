//
//  BreweriesList.swift
//  DrinkLocally
//
//  Created by Brent Busby on 8/31/23.
//

import Foundation
import CoreLocation

class BreweriesList: ObservableObject {
    private let apiClient: NetworkProtocol
    @Published private(set) var locationService: LocationService
    @Published private(set) var breweries = [Brewery]()
    @Published private(set) var selectedBrewery: Brewery? = nil
    @Published private(set) var requestInProgress = false
    @Published private(set) var locationError = false
    
    init(locationManager: CLLocationManager, apiClient: NetworkProtocol = APIClient()) {
        self.apiClient = apiClient
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
        locationService.retrieveLocation()
        self.requestInProgress = true
        
        guard let url = URL(string: Endpoints.breweriesListBaseURLString + locationString()) else { return }
        
        self.breweries = try await apiClient.fetchBreweries(url: url)
        self.requestInProgress = false
    }
    
    @MainActor
    func populateSelectedBrewery(breweryId: String) async throws {
        
        guard let url = URL(string: Endpoints.singleBreweryURLString + breweryId) else { return }
        self.selectedBrewery = try await apiClient.fetchSingleBrewery(url: url)
    }
    
    private func locationString() -> String {
        guard let location = locationService.currentLocation else {
            locationError = true
            return "0.000,0.000"
        }
        return String(location.coordinate.latitude) + "," + String(location.coordinate.longitude)
    }
}
