//
//  ErrorView.swift
//  DrinkLocally
//
//  Created by Brent Busby on 12/18/23.
//

import SwiftUI

struct ErrorView: View {
    let errorMessage: String
    var body: some View {
        VStack {
            Text(errorMessage)
        }
        .frame(width: 350, height: 100)
        .background(.orange)
        .cornerRadius(10)
    }
}

#Preview {
    ErrorView(errorMessage: "Shit's broken.")
}
