//
//  MockNetworking.swift
//  DrinkLocallyTests
//
//  Created by Brent Busby on 8/23/23.
//

import Foundation
@testable import DrinkLocally

class MockAPIClient: NetworkProtocol {
    func fetchBreweries(url: URL) async throws -> [Brewery] {
        let data = sampleData(bundle: Bundle(for: type(of: self)))
        
        let breweries = try JSONDecoder().decode([Brewery].self, from: data)
        return breweries
    }
    
    func fetchSingleBrewery(url: URL) async throws -> Brewery {
        let data = sampleSingleBreweryData(bundle: Bundle(for: type(of: self)))
        let brewery = try JSONDecoder().decode(Brewery.self, from: data)
        return brewery
    }
    
    private func sampleData(bundle: Bundle) -> Data {
        let fileURL = bundle.url(forResource: "BreweriesResponse", withExtension: "json")
        let data = try? Data(contentsOf: fileURL!)
        return data!
    }
    
    private func sampleSingleBreweryData(bundle: Bundle) -> Data {
        let fileURL = bundle.url(forResource: "SingleBreweryResponse", withExtension: "json")
        let data = try? Data(contentsOf: fileURL!)
        return data!
    }
}
