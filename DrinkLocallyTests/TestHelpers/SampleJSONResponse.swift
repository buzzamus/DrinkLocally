//
//  File.swift
//  DrinkLocallyTests
//
//  Created by Brent Busby on 9/1/23.
//

import Foundation

struct SampleJSONResponse {
    func sampleData(bundle: Bundle) -> Data {
        let fileURL = bundle.url(forResource: "BreweriesResponse", withExtension: "json")
        let data = try! Data(contentsOf: fileURL!)
        return data
    }
}
