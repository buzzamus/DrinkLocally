//
//  LocationRefreshView.swift
//  DrinkLocally
//
//  Created by Brent Busby on 5/3/24.
//

import SwiftUI
import CoreLocation

struct BreweryRefreshView: View {
    let viewModel: BreweriesList
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.brown)
                .frame(width: 50, height: 50)
            
            Button(action: {
                Task {
                    do {
                        try await refreshBreweries()
                    } catch {
                        print("Error refreshing breweries: \(error)")
                    }
                }
            }) {
                Image(systemName: "arrow.clockwise")
                    .foregroundColor(.white)
            }
            .frame(width: 50, height: 50)
        }
        .padding(.bottom, 20)
        .padding(.trailing, 20)
    }
    
    private func refreshBreweries() async throws {
        try await viewModel.populateBreweries()
    }
}

#Preview {
    BreweryRefreshView(viewModel: BreweriesList(locationManager: CLLocationManager()))
}
