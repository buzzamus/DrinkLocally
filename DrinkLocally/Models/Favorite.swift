//
//  Favorite.swift
//  DrinkLocally
//
//  Created by Brent Busby on 1/27/24.
//

import Foundation
import SwiftData

@Model
class Favorite {
    let brewery: Brewery
    
    init(brewery: Brewery) {
        self.brewery = brewery
    }
}
