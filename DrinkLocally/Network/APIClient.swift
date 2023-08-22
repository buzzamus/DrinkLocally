//
//  APIClient.swift
//  DrinkLocally
//
//  Created by Brent Busby on 8/19/23.
//

import Foundation

class APIClient {
    enum URLError: Error {
        case invalidURL
    }
//    static let shared = APIClient()
    private let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchBreweries() async throws -> Result {
        guard let url = Endpoints.breweriesListURL else {
            throw URLError.invalidURL
        }
        
        let (data, _) = try await urlSession.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(Result.self, from: data)
    }
}
