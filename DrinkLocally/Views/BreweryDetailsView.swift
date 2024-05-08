//
//  BreweryDetailsView.swift
//  DrinkLocally
//
//  Created by Brent Busby on 9/19/23.
//

import SwiftUI
import MapKit
import SwiftData

struct BreweryDetailsView: View {
    let brewery: Brewery
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @State var breweryLocation = CLLocationCoordinate2D()
    @Environment(\.modelContext) var modelContext
    @Query var favorites: [Favorite]
    @State private var showAlert = false
    
    private var textColor: Color {
        if colorScheme == .dark {
            return Color.white
        } else {
            return Color.black
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            SwipeDownView(indicatorColor: textColor)
                .frame(maxWidth: .infinity, alignment: .center)
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(textColor)
            }
            .padding(.trailing, 20)
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            Text(brewery.name)
                .font(.title)
            if region.center.latitude != 0.0 && region.center.longitude != 0.0 {
                Map(initialPosition: .region(region)) {
                    Marker(brewery.name, coordinate: breweryLocation)
                    UserAnnotation()
                }
                .frame(minWidth: 400, maxWidth: 400, minHeight: 450, maxHeight: 450)
            }
            Spacer()
            Group {
                Text(brewery.address1 ?? "")
                    .font(.subheadline)
                Text(brewery.city ?? "")
                    .font(.subheadline)
                Text(brewery.stateProvince ?? "")
                    .font(.subheadline)
                Divider()
                
                Spacer()
                Spacer()
                if ((brewery.websiteURL) != nil) {
                    Link("\(brewery.name)'s Website",
                         destination: URL(string: brewery.websiteURL!)!)
                    .font(.headline)
                }
                
            }
            Spacer()
            Spacer()
            Spacer()
            Button {
                actionCheck()
            } label: {
                Text(buttonText())
                    .frame(width: 400, height: 70)
                    .background(.brown)
                    .foregroundColor(.white)
                    .buttonStyle(BorderlessButtonStyle())
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Confirm Unfavorite"), message: Text("Are you sure you want to unfavorite this brewery?"), primaryButton: .cancel(), secondaryButton: .destructive(Text("Unfavorite")) {
                    deleteFavorite()
                })
            }
            Spacer()
        }
        .onAppear(perform: {
            setCoordinates()
        })
        Spacer()
    }
    
    //TODO: move these methods into a view model, create tests
    
    private func setCoordinates() {
        guard let latitude = Double(brewery.latitude!) else {
            return
        }
        
        guard let longitude = Double(brewery.longitude!) else {
            return
        }
        
        self.breweryLocation.latitude = latitude
        self.breweryLocation.longitude = longitude
        
        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015))
    }
    
    // TODO: addFavorite, deleteFavorite, actionCheck and isFavorited should be moved to viewModel...or possibly a different class within viewModel
    private func addFavorite() {
        guard !isFavorited(for: brewery) else {
            modelContext.delete(Favorite(brewery: brewery))
            print("Brewery already favorited. Deleting.")
            try? modelContext.save()
            return
        }
        
        let favorite = Favorite(brewery: brewery)
        modelContext.insert(favorite)
    }
    
    private func deleteFavorite() {
        guard let favoriteToDelete = favorites.first(where: { $0.id == brewery.id}) else {
            print("Favorite not found")
            return
        }
        
        modelContext.delete(favoriteToDelete)
        
        do {
            try modelContext.save()
            print("Favorite deleted.")
        } catch {
            print("Error deleing Favorite: \(error)")
        }
    }
    
    private func actionCheck() {
        if isFavorited(for: brewery) {
            showAlert = true
        } else {
            addFavorite()
        }
    }
    
    private func isFavorited(for brewery: Brewery) -> Bool {
        return favorites.contains { favorite in
            favorite.id == brewery.id
        }
    }
    
    private func buttonText() -> String {
        if isFavorited(for: brewery) {
            return "Unfavorite this brewery"
        } else {
            return "Favorite this brewery"
        }
    }
}

struct BreweryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BreweryDetailsView(brewery: Brewery(id: "1", name: "Riverlands Brewing Company", breweryType: "micro", address1: "1860 Dean St Unit A", address2: nil, address3: nil, city: "Saint Charles", stateProvince: "IL", postalCode: "60174", country: "United States", longitude: "-88.3378043891987", latitude: "41.9187859535333", phone: "(630) 549-6293", websiteURL: "riverlandsbrewing.com", state: "IL", street: nil))
    }
}
