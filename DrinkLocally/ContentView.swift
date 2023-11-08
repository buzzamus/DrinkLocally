//
//  ContentView.swift
//  DrinkLocally
//
//  Created by Brent Busby on 8/19/23.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    var body: some View {
        TabView {
            BreweriesListView(viewModel: BreweriesList(locationManager: CLLocationManager()))
                .tabItem { 
                    Image(systemName: "list.bullet")
                    Text("Nearby Breweries")
                }
            MapView()
                .tabItem {
                    Image(systemName: "globe.americas")
                    Text("Map View")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
