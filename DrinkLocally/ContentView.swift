//
//  ContentView.swift
//  DrinkLocally
//
//  Created by Brent Busby on 8/19/23.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @ObservedObject var locationService = LocationService(locationManager: CLLocationManager())
    @State var apiClient = APIClient()
    @State var breweries: [Brewery] = []
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(String(locationService.currentLocation?.coordinate.latitude ?? -66.6666))
            Text(String(locationService.currentLocation?.coordinate.longitude ?? -66.6666))
        }
        .onAppear(perform: locationService.retrieveLocation)
        .task {
            do {
                breweries = try await populateBreweries()
                print(breweries)
            } catch {
                print("fuck")
            }
        }
    }
    
    func populateBreweries() async throws -> [Brewery] {
        breweries = try await apiClient.fetchBreweries(url: URL(string: "https://api.openbrewerydb.org/v1/breweries?per_page=3")!)
        return breweries
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
