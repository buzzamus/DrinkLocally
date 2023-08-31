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
    let locationService: LocationService
    @Published var breweries = [Brewery]()
    
    init(locationManager: CLLocationManager) {
        self.apiClient = APIClient()
        self.locationService = LocationService(locationManager: locationManager)
    }
    
    func setupLocationServices() {
        locationService.retrieveLocation()
    }
    
    @MainActor
    func populateBreweries() async throws {
        guard let url = URL(string: Endpoints.breweriesListBaseURLString + locationString()) else { return }
        do {
            print(url)
            self.breweries = try await apiClient.fetchBreweries(url: url)
        } catch {
            print("An error occurred retrieving brewery data: \(error)")
        }
    }
    
    private func locationString() -> String {
        if let location = locationService.currentLocation {
            return String(location.coordinate.latitude) + "," + String(location.coordinate.longitude)
        } else {
            // TODO: This needs to be handled
            return ""
        }
    }
}
