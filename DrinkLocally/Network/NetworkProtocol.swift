//
//  BreweryRequest.swift
//  DrinkLocally
//
//  Created by Brent Busby on 8/21/23.
//

import Foundation

protocol NetworkProtocol {
    func fetchBreweries(url: URL) async throws -> [Brewery]
    func fetchSingleBrewery(url: URL) async throws -> Brewery
}
