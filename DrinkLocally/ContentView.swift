//
//  ContentView.swift
//  DrinkLocally
//
//  Created by Brent Busby on 8/19/23.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @ObservedObject var viewModel = BreweriesList(locationManager: CLLocationManager())
    var body: some View {
        TabView {
            BreweriesListView(viewModel: viewModel)
                .tabItem { 
                    Image(systemName: "list.bullet")
                    Text("Nearby Breweries")
                }
            MapView(viewModel: viewModel)
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
