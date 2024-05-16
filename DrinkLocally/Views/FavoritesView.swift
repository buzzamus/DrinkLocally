//
//  FavoritesView.swift
//  DrinkLocally
//
//  Created by Brent Busby on 2/5/24.
//

import SwiftUI
import CoreLocation
import SwiftData

struct FavoritesView: View {
    @ObservedObject var viewModel: BreweriesList
    @State private var selectedBrewery: Brewery?
    var favorites: [Favorite]
    @Environment(\.modelContext) var modelContext
    var body: some View {
        NavigationStack {
            Divider()
            if favorites.isEmpty {
                Text("No favorites added yet.")
                Text("Go find some good breweries!")
            }
            List {
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
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        let favorite = favorites[index]
                        modelContext.delete(favorite)
                    }
                })
            }
            .listStyle(PlainListStyle())
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
