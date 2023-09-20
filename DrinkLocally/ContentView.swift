//
//  ContentView.swift
//  DrinkLocally
//
//  Created by Brent Busby on 8/19/23.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    var body: some View {
        BreweriesListView(viewModel: BreweriesList(locationManager: CLLocationManager()))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
