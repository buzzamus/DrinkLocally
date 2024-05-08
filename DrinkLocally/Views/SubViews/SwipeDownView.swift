//
//  SwipeDownView.swift
//  DrinkLocally
//
//  Created by Brent Busby on 5/7/24.
//

import SwiftUI

struct SwipeDownView: View {
    let indicatorColor: Color
    var body: some View {
        Rectangle()
            .fill(indicatorColor)
            .frame(width: 100, height: 5)
            .cornerRadius(2)
            .padding(.vertical, 8)
    }
}

#Preview {
    SwipeDownView(indicatorColor: Color.black)
}
