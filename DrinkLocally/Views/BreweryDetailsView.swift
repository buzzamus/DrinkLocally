//
//  BreweryDetailsView.swift
//  DrinkLocally
//
//  Created by Brent Busby on 9/19/23.
//

import SwiftUI
import MapKit

struct BreweryDetailsView: View {
    let brewery: Brewery
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @State var breweryLocation = CLLocationCoordinate2D()
    var body: some View {
        VStack {
            Text(brewery.name)
                .font(.title)
            if region.center.latitude != 0.0 && region.center.longitude != 0.0 {
                Map(initialPosition: .region(region)) {
                    Marker(brewery.name, coordinate: breweryLocation)
                    UserAnnotation()
                }
                .frame(minWidth: 400, maxWidth: 400, minHeight: 500, maxHeight: 500)
            }
            Spacer()
            Group {
                Text(brewery.address1 ?? "")
                    .font(.title)
                Text(brewery.city ?? "")
                    .font(.title)
                Text(brewery.stateProvince ?? "")
                    .font(.title)
                Divider()
                
                if ((brewery.websiteURL) != nil) {
                    Link("Website",
                         destination: URL(string: brewery.websiteURL!)!)
                    .font(.title)
                }
                
            }
            Spacer()
            Spacer()
        }
        .onAppear(perform: {
            setCoordinates()
        })
    }
    
    private func setCoordinates() {
        guard let latitude = Double(brewery.latitude!) else {
            return
        }
        
        guard let longitude = Double(brewery.longitude!) else {
            return
        }
        
        self.breweryLocation.latitude = latitude
        self.breweryLocation.longitude = longitude
        
        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    }
}

struct BreweryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BreweryDetailsView(brewery: Brewery(id: "1", name: "Riverlands Brewing Company", breweryType: "micro", address1: "1860 Dean St Unit A", address2: nil, address3: nil, city: "Saint Charles", stateProvince: "IL", postalCode: "60174", country: "United States", longitude: "-88.3378043891987", latitude: "41.9187859535333", phone: "(630) 549-6293", websiteURL: "riverlandsbrewing.com", state: "IL", street: nil))
    }
}
