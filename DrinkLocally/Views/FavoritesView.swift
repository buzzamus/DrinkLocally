//
//  FavoritesView.swift
//  DrinkLocally
//
//  Created by Brent Busby on 2/5/24.
//

import SwiftUI
import CoreLocation

struct FavoritesView: View {
    @ObservedObject var viewModel: BreweriesList
    @State private var selectedBrewery: Brewery?
    var favorites: [Favorite]
    var body: some View {
        NavigationStack {
            Divider()
            if favorites.isEmpty {
                Text("No favorites added yet.")
                Text("Go find some good breweries!")
            }
            ScrollView {
                ForEach(favorites) { favorite in
                    VStack(alignment: .leading) {
                        Button {
                            Task {
                                try await viewModel.populateSelectedBrewery(breweryId: favorite.id)
                                self.selectedBrewery = viewModel.selectedBrewery
                            }

                        } label: {
                            Text(favorite.name)
                                .frame(width: 400, height: 70)
                                .background(.brown)
                                .foregroundColor(.white)
                                .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
            }
            .sheet(item: $selectedBrewery) { brewery in
                BreweryDetailsView(brewery: brewery)
            }
            .navigationTitle("Favorite Breweries")
        }
    }
}

#Preview {
    FavoritesView(viewModel: BreweriesList(locationManager: CLLocationManager()), favorites: [])
}
