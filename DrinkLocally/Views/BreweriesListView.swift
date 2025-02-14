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
            HeadlineView(headline: "Nearby Breweries")

            if viewModel.requestInProgress && networkError == false {
                ProgressView("Retrieving Data...")
                    .foregroundColor(.gray)
            }

            if networkError {
                ErrorView(errorMessage: errorMessage)
            }

            ScrollView {
                BreweryButtonListView(breweries: viewModel.breweries, selectedBrewery: $selectedBrewery)
            }
            .sheet(item: $selectedBrewery) { brewery in
                BreweryDetailsView(brewery: brewery)
            }

            // Refresh Button Inline
            HStack {
                Spacer()
                Button(action: {
                    Task {
                        await refreshBreweries()
                    }
                }) {
                    ZStack {
                        Circle()
                            .foregroundColor(.brown)
                            .frame(width: 50, height: 50)

                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.white)
                    }
                }
                .padding(.bottom, 20)
                .padding(.trailing, 20)
            }
        }
        .onAppear {
            Task {
                networkError = false
                do {
                    try await viewModel.populateBreweries()
                } catch {
                    print(error)
                    networkError = true
                }
            }
        }
    }

    private func refreshBreweries() async {
        do {
            try await viewModel.populateBreweries()
        } catch {
            print("Error refreshing breweries: \(error)")
            networkError = true
        }
    }
}


struct BreweriesListView_Previews: PreviewProvider {
    static var previews: some View {
        BreweriesListView(viewModel: BreweriesList(locationManager: CLLocationManager()))
    }
}
