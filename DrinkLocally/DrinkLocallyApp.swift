//
//  DrinkLocallyApp.swift
//  DrinkLocally
//
//  Created by Brent Busby on 8/19/23.
//


import SwiftData
import SwiftUI

@main
struct DrinkLocallyApp: App {
    var body: some Scene {
        WindowGroup {
            
            ContentView()
        }
        .modelContainer(for: Favorite.self)
    }
}
