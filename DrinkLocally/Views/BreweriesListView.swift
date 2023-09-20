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
    @State var detailsViewEnabled = false
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.breweries) { brewery in
                    Button(brewery.name) {
                        detailsViewEnabled.toggle()
                    }
                    .sheet(isPresented: $detailsViewEnabled) {
                        BreweryDetailsView(brewery: brewery)
                    }
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
}

struct BreweriesListView_Previews: PreviewProvider {
    static var previews: some View {
        BreweriesListView()
    }
}
