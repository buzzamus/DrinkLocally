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
    @Query var favorites: [Favorite]
    var body: some View {
        VStack {
            HeadlineView(headline: "Find Local Breweries")
            
            Map {
                ForEach(viewModel.breweries, id: \.self.id) { brewery in
                    let latitude = brewery.latitude ?? 0.0
                    var longitude: Double = brewery.longitude ?? 0.0
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

                UserAnnotation()
            }
            .sheet(item: $selectedBrewery) { brewery in
                BreweryDetailsView(brewery: brewery)
            }
            .frame(minWidth: 400, maxWidth: 400, minHeight: 300, maxHeight: 350)
            Spacer()
            
            Divider()
            ScrollView {
                
                if viewModel.requestInProgress {
                    ProgressView("Retrieving Data...")
                        .foregroundColor(.gray)
                }
                BreweryButtonListView(breweries: viewModel.breweries, selectedBrewery: $selectedBrewery)
            }
            HStack {
                Spacer()
                BreweryRefreshView(viewModel: viewModel)
            }
        }
    }
    
    func toDouble(coordinate: String) -> Double {
        Double(coordinate) ?? 0.0
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
}

#Preview {
    MapView(viewModel: BreweriesList(locationManager: CLLocationManager()))
}
