//
//  Brewery.swift
//  DrinkLocally
//
//  Created by Brent Busby on 8/19/23.
//

import Foundation

struct Brewery: Codable, Identifiable {
    let id, name: String
    let breweryType, address1, address2, address3: String?
    let city, stateProvince, postalCode, country: String?
    let longitude, latitude, phone, websiteURL: String?
    let state, street: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case breweryType = "brewery_type"
        case address1 = "address_1"
        case address2 = "address_2"
        case address3 = "address_3"
        case city
        case stateProvince = "state_province"
        case postalCode = "postal_code"
        case country, longitude, latitude, phone
        case websiteURL = "website_url"
        case state, street
    }
}
