//
//  MockNetworking.swift
//  DrinkLocallyTests
//
//  Created by Brent Busby on 8/23/23.
//

import Foundation
@testable import DrinkLocally

class MockNetworking: Networking {
    var dataForDelegateReturnValue: (Data, URLResponse)?
    var dataForDelegateRequest: URLRequest?
    
    func data(
        for request: URLRequest,
        delegate: URLSessionTaskDelegate?
    ) async throws -> (Data, URLResponse) {
        dataForDelegateRequest = request
        
        guard let dataForDelegateReturnValue = dataForDelegateReturnValue else {
            fatalError()
        }
        return dataForDelegateReturnValue
    }
}
