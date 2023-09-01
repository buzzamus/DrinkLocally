//
//  Endpoints.swift
//  DrinkLocally
//
//  Created by Brent Busby on 8/21/23.
//

import Foundation

class Endpoints {
    static let singleBreweryURL = URL(string: "https://api.openbrewerydb.org/v1/breweries/")
    static let breweriesListURL = URL(string: "https://api.openbrewerydb.org/v1/breweries")
    static let breweriesListBaseURLString = "https://api.openbrewerydb.org/v1/breweries?by_dist="
}
