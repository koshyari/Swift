//
//  Dishes.swift
//  JSONParser
//
//  Created by Anshul Singh Koshyari on 08/06/21.
//

import Foundation

struct Dish: Codable {
    var id: String?
    var type: String?
    var name: String?
    var ppu: Double?
    var batters: Alpha?
    var topping: [Toppings]?
}

struct Alpha: Codable {
    var batter: [Toppings]?
}

struct Toppings: Codable {
    var id: String?
    var type: String?
}
