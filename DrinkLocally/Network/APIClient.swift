//
//  APIClient.swift
//  DrinkLocally
//
//  Created by Brent Busby on 8/19/23.
//

import Foundation

class APIClient {
    lazy var session: Networking = URLSession.shared

    init(networking: Networking = URLSession.shared) {
        self.session = networking
    }
    
    func fetchBreweries(url: URL) async throws -> [Brewery] {
        let request = URLRequest(url: url)
        let (data, _) = try await session.data(for: request, delegate: nil)
        return try JSONDecoder().decode([Brewery].self, from: data)
    }
}
