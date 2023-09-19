//
//  BreweryRequest.swift
//  DrinkLocally
//
//  Created by Brent Busby on 8/21/23.
//

import Foundation

protocol NetworkProtocol {
    func fetchData(url: URL) async throws -> [Brewery]
}
