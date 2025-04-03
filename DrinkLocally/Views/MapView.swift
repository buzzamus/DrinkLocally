//
//  MapView.swift
//  DrinkLocally
//
//  Created by Brent Busby on 10/7/23.
//

import SwiftUI
import MapKit
import SwiftData

struct MapView: View {
    @StateObject var viewModel: BreweriesList
    @State private var selectedBrewery: Brewery?
    @State private var networkError = false
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var userLocation: CLLocation?
    @Query var favorites: [Favorite]
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                HeadlineView(headline: "Find Local Breweries")
                Map(position: $cameraPosition) {
                    ForEach(viewModel.breweries, id: \.self.id) { brewery in
                        let latitude = brewery.latitude ?? 0.0
                        let longitude: Double = brewery.longitude ?? 0.0
                        Annotation(brewery.name, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)) {
                            Image(systemName: mapIcon(brewery: brewery))
                                .padding()
                                .background(.red)
                                .clipShape(Circle())
                                .onTapGesture {
                                    self.selectedBrewery = brewery
                                }
                        }
                    }
                }
                .refreshable {
                    await refreshBreweries()
                }
                .sheet(item: $selectedBrewery) { brewery in
                    BreweryDetailsView(brewery: brewery)
                }
            }

            Button(action: {
                Task {
                    await refreshBreweries()
                    refreshUserLocation()
                }
            }) {
                Image(systemName: "arrow.clockwise")
                    .font(.title)
                    .padding()
                    .background(Color.brown)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 5)
            }
            .padding()
        }
    }

    
    private func refreshBreweries() async {
        Task {
            networkError = false
            do {
                try await viewModel.populateBreweries()
            } catch {
                print("Error refreshing breweries: \(error)")
                networkError = true
            }
        }
    }
    
    private func mapIcon(brewery: Brewery) -> String {
        let favorited = favorites.contains { favorite in
            favorite.id == brewery.id
        }
        
        if favorited {
            return "star"
        } else {
            return "mappin"
        }
    }
    
    private func refreshUserLocation() {
        if let latestLocation = viewModel.locationService.currentLocation {
            userLocation = latestLocation
            cameraPosition = .region(
                MKCoordinateRegion(
                    center: latestLocation.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                )
            )
        }
    }
}

#Preview {
    MapView(viewModel: BreweriesList(locationManager: CLLocationManager()))
}
