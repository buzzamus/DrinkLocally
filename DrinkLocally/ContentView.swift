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
        LazyVStack {
            ForEach(viewModel.breweries) { brewery in
                Text(brewery.name)
            }
        }
        .onAppear(perform: viewModel.setupLocationServices)
        .task {
            do {
                try await viewModel.populateBreweries()
            } catch {
                print(error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
