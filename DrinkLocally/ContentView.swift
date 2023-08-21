//
//  ContentView.swift
//  DrinkLocally
//
//  Created by Brent Busby on 8/19/23.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @ObservedObject var locationService = LocationService(locationManager: CLLocationManager())
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(String(locationService.currentLocation?.coordinate.latitude ?? -66.6666))
        }
        .onAppear(perform: locationService.getLocation)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
