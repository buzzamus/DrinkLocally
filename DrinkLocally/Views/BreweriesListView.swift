//
//  BreweriesListView.swift
//  DrinkLocally
//
//  Created by Brent Busby on 9/19/23.
//

import SwiftUI
import CoreLocation

struct BreweriesListView: View {
    @ObservedObject var viewModel = BreweriesList(locationManager: CLLocationManager())
    @State private var selectedBrewery: Brewery?
    @State private var networkError = false
    var body: some View {
        if viewModel.requestInProgress {
            ProgressView("Retrieving Data...")
                .foregroundColor(.purple)
        }
        
        ScrollView {
            LazyVStack {
                ForEach(viewModel.breweries, id: \.self.id) { brewery in
                    Button(brewery.name) {
                        self.selectedBrewery = brewery
                    }
                    .frame(minWidth: 300, maxWidth: 300)
                    .background(.purple)
                    .foregroundColor(.white)
                    .buttonStyle(.bordered)
                    .cornerRadius(10)
                }
            }
            .onAppear(perform: viewModel.setupLocationServices)
            .task {
                do {
                    try await viewModel.populateBreweries()
                } catch {
                    print(error)
                    networkError = true
                }
            }
        }
        .sheet(item: $selectedBrewery) { brewery in
            BreweryDetailsView(brewery: brewery)
        }
    }
}

struct BreweriesListView_Previews: PreviewProvider {
    static var previews: some View {
        BreweriesListView()
    }
}
