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
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    var body: some View {
        Map {
            ForEach(viewModel.breweries, id: \.self.id) { brewery in
                Marker(brewery.name, coordinate: CLLocationCoordinate2D(latitude: toDouble(coordinate: brewery.latitude ?? "0.0"), longitude: toDouble(coordinate: brewery.longitude ?? "0.0")))
            }
            //            Marker(brewery.name, coordinate: breweryLocation)
        }.frame(minWidth: 400, maxWidth: 400, minHeight: 400, maxHeight: 400)
    }
    
    func toDouble(coordinate: String) -> Double {
        Double(coordinate) ?? 0.0
    }
}

#Preview {
    MapView(viewModel: BreweriesList(locationManager: CLLocationManager()))
}
