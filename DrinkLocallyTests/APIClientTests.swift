//
//  NetworkingTests.swift
//  DrinkLocallyTests
//
//  Created by Brent Busby on 8/25/23.
//

import XCTest
@testable import DrinkLocally

final class APIClientTests: XCTestCase {
    private var networking: MockNetworking!
    private var apiClient: APIClient!
    
    override func setUpWithError() throws {
        networking = MockNetworking()
        apiClient = APIClient(networking: networking)
    }

    override func tearDownWithError() throws {
        networking = nil
        apiClient = nil
    }
    
    func test_NetworkingDecodesData() throws {
        let url = try XCTUnwrap(Endpoints.breweriesListURL)
        let urlSessionMock = MockNetworking()
        
        let sampleJSONResponse = SampleJSONResponse()
        let sampleData = sampleJSONResponse.sampleData(bundle: Bundle(for: type(of: self)))
        
        let expected = try JSONDecoder().decode([Brewery].self, from: Data(sampleData))
        urlSessionMock.dataForDelegateReturnValue = (
            try JSONEncoder().encode(expected),
            HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        )
    }
}
