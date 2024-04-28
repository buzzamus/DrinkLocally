//
//  BreweriesListView.swift
//  DrinkLocally
//
//  Created by Brent Busby on 9/19/23.
//

import SwiftUI
import CoreLocation

struct BreweriesListView: View {
    @ObservedObject var viewModel: BreweriesList
    @State private var selectedBrewery: Brewery?
    @State private var networkError = false
    let errorMessage = "A network error occurred. Try again later."
    var body: some View {
        VStack {
            Text("Nearby Breweries")
                .font(.largeTitle)
            
            Divider()
            
            if viewModel.requestInProgress && networkError == false {
                ProgressView("Retrieving Data...")
                    .foregroundColor(.gray)
            }
            
            if networkError {
                ErrorView(errorMessage: errorMessage)
            }

            ScrollView {
                BreweryButtonListView(breweries: viewModel.breweries, selectedBrewery: $selectedBrewery)
                .onAppear(perform: viewModel.setupLocationServices)
                .task {
                    do {
                        try await viewModel.populateBreweries()
                    } catch {
                        print(error)
                        networkError = true
                    }
                }
                .onChange(of: viewModel.locationService.currentLocation) {
                    print("current location changed....")
                    Task {
                        do {
                            try await viewModel.populateBreweries()
                        } catch {
                            print(error)
                            networkError = true
                        }
                    }
                }
            }
            .sheet(item: $selectedBrewery) { brewery in
                BreweryDetailsView(brewery: brewery)
            }
        }
    }
}

struct BreweriesListView_Previews: PreviewProvider {
    static var previews: some View {
        BreweriesListView(viewModel: BreweriesList(locationManager: CLLocationManager()))
    }
}
