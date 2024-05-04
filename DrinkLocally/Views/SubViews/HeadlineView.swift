//
//  SwiftUIView.swift
//  DrinkLocally
//
//  Created by Brent Busby on 5/4/24.
//

import SwiftUI

struct HeadlineView: View {
    let headline: String
    var body: some View {
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Text(headline)
            .font(.largeTitle)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.leading, .top], 20)
        Spacer()
        Divider()
    }
}

#Preview {
    HeadlineView(headline: "Nearby Breweries")
}
