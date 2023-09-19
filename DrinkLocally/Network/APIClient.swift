//
//  APIClient.swift
//  DrinkLocally
//
//  Created by Brent Busby on 8/19/23.
//

import Foundation

class APIClient: NetworkProtocol {
    func fetchData(url: URL) async throws -> [Brewery] {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Brewery].self, from: data)
    }
}
