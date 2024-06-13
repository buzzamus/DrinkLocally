//
//  BreweryButtonScrollView.swift
//  DrinkLocally
//
//  Created by Brent Busby on 12/26/23.
//

import SwiftUI
import SwiftData

struct BreweryButtonListView: View {
    let breweries: [Brewery]
    @Binding var selectedBrewery: Brewery?
    @Query var favorites: [Favorite]
    var body: some View {
        LazyVStack(spacing: 0) {
            ForEach(breweries, id: \.self.id) { brewery in
                Button {
                    self.selectedBrewery = brewery
                } label: {
                    buttonDisplayName(brewery: brewery)
                        .frame(maxWidth: .infinity, minHeight: 70)
                        .background(.brown)
                        .foregroundColor(.white)
                        .buttonStyle(BorderlessButtonStyle())
                }
                .padding(.vertical, 0)
                Divider().background(.black)
            }
        }
    }
    
    private func buttonDisplayName(brewery: Brewery) -> Text {
        let favorited = favorites.contains { favorite in
            favorite.id == brewery.id
        }
        
        if favorited {
            return Text("\(brewery.name)  \(Image(systemName: "star"))")
        } else {
            return Text(brewery.name)
        }
    }
}

// disabled as this child view is previewed/tested within the parent views
//#Preview {
//    BreweryButtonListView(breweries: [], selectedBrewery: nil)
//}
