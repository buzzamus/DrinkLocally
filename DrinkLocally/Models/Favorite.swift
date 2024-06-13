//
//  Favorite.swift
//  DrinkLocally
//
//  Created by Brent Busby on 1/27/24.
//

import Foundation
import SwiftData

@Model
final class Favorite {
    var name: String = ""
    var id: String = ""
    
    init(brewery: Brewery) {
        self.name = brewery.name
        self.id = brewery.id
    }
}
