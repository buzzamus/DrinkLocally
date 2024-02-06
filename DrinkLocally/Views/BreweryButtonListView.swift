//
//  BreweryButtonScrollView.swift
//  DrinkLocally
//
//  Created by Brent Busby on 12/26/23.
//

import SwiftUI

struct BreweryButtonListView: View {
    let breweries: [Brewery]
    @Binding var selectedBrewery: Brewery?
    var body: some View {
        LazyVStack {
            ForEach(breweries, id: \.self.id) { brewery in
                Button {
                    self.selectedBrewery = brewery
                } label: {
                    Text(brewery.name)
                        .frame(width: 400, height: 70)
                        .background(.brown)
                        .foregroundColor(.white)
                        .buttonStyle(BorderlessButtonStyle())
//                        .cornerRadius(10)
                }
            }
        }
    }
}

// disabled as this child view is previewed/tested within the parent views
//#Preview {
//    BreweryButtonListView(breweries: [], selectedBrewery: nil)
//}
