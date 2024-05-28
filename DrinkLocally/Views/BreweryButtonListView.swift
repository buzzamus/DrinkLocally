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
        LazyVStack(spacing: 0) {
            ForEach(breweries, id: \.self.id) { brewery in
                Button {
                    self.selectedBrewery = brewery
                } label: {
                    Text(brewery.name)
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
}


//struct BreweryButtonListView: View {
//    let breweries: [Brewery]
//    @Binding var selectedBrewery: Brewery?
//    
//    var body: some View {
//        List(breweries, id: \.self.id) { brewery in
//            Button {
//                self.selectedBrewery = brewery
//            } label: {
//                Text(brewery.name)
//                    .frame(maxWidth: .infinity, minHeight: 70, alignment: .leading)
//                    .background(Color.brown)
//                    .foregroundColor(.white)
//            }
//            .buttonStyle(BorderlessButtonStyle())
//            .listRowBackground(Color.brown) // To ensure the button background is consistent
//        }
//        .listStyle(PlainListStyle())
//    }
//}




// disabled as this child view is previewed/tested within the parent views
//#Preview {
//    BreweryButtonListView(breweries: [], selectedBrewery: nil)
//}
