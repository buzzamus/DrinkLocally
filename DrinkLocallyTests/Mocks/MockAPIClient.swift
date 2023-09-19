//
//  MockNetworking.swift
//  DrinkLocallyTests
//
//  Created by Brent Busby on 8/23/23.
//

import Foundation
@testable import DrinkLocally

class MockAPIClient: APIClient {
    override func fetchData(url: URL) async throws -> [Brewery] {
        let data = sampleData(bundle: Bundle(for: type(of: self)))
        
        let user = try JSONDecoder().decode([Brewery].self, from: data)
        return user
    }
    
    private func sampleData(bundle: Bundle) -> Data {
        let fileURL = bundle.url(forResource: "BreweriesResponse", withExtension: "json")
        let data = try? Data(contentsOf: fileURL!)
        return data!
    }
}
