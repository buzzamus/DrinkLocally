//
//  BreweryRequest.swift
//  DrinkLocally
//
//  Created by Brent Busby on 8/21/23.
//

import Foundation

protocol Networking {
    func data(
        for request: URLRequest,
        delegate: URLSessionTaskDelegate?
    ) async throws -> (Data, URLResponse)
}

extension URLSession: Networking {}

