//
//  MapView.swift
//  DrinkLocally
//
//  Created by Brent Busby on 10/7/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject var viewModel: BreweriesList
    @State private var selectedBrewery: Brewery?
    var body: some View {
        VStack {
            Text("Find Local Breweries")
                .font(.largeTitle)
            Divider()
            
            Map {
                ForEach(viewModel.breweries, id: \.self.id) { brewery in
                    Annotation(brewery.name, coordinate: CLLocationCoordinate2D(latitude: toDouble(coordinate: brewery.latitude ?? "0.0"), longitude: toDouble(coordinate: brewery.longitude ?? "0.0"))) {
                        Image(systemName: "mappin")
                            .foregroundStyle(.black)
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
            .frame(minWidth: 400, maxWidth: 400, minHeight: 300, maxHeight: 300)
            Spacer()
            
            Divider()
            ScrollView {
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
}

#Preview {
    MapView(viewModel: BreweriesList(locationManager: CLLocationManager()))
}
