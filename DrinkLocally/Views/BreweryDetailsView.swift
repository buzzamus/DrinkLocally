//
//  BreweryDetailsView.swift
//  DrinkLocally
//
//  Created by Brent Busby on 9/19/23.
//

import SwiftUI

struct BreweryDetailsView: View {
    let brewery: Brewery
    var body: some View {
        Text(brewery.name)
    }
}

struct BreweryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BreweryDetailsView(brewery: Brewery(id: "1", name: "Riverlands Brewing Company", breweryType: "micro", address1: "1860 Dean St Unit A", address2: nil, address3: nil, city: "Saint Charles", stateProvince: "IL", postalCode: "60174", country: "United States", longitude: "-88.3378043891987", latitude: "41.9187859535333", phone: "(630) 549-6293", websiteURL: "riverlandsbrewing.com", state: "IL", street: nil))
    }
}
