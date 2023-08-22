//
//  Brewery.swift
//  DrinkLocally
//
//  Created by Brent Busby on 8/19/23.
//

import Foundation

struct Brewery: Codable {
    let id, name, breweryType, address1: String
    let address2, address3: String?
    let city, stateProvince, postalCode, country: String
    let longitude, latitude, phone: String
    let websiteURL: String
    let state, street: String

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
