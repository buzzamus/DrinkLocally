//
//  ContentView.swift
//  DrinkLocally
//
//  Created by Brent Busby on 8/19/23.
//

import SwiftUI
import CoreLocation
import SwiftData

struct ContentView: View {
    @Query var favorites: [Favorite]
    @StateObject var viewModel = BreweriesList(locationManager: CLLocationManager())
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
            
            FavoritesView(viewModel: viewModel, favorites: favorites)
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
