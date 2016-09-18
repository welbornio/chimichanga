//
//  Location.swift
//  chimichanga
//
//  Created by shake on 9/13/16.
//  Copyright © 2016 welbornio. All rights reserved.
//

import Foundation

struct Location {
    var city: String
    var temperature: Float?
    var icon: String?
    
    init(city: String) {
        self.city = city
    }
    
    mutating func setTemperature (temperature: Float) {
        self.temperature = temperature
    }
    
    mutating func setIcon (icon: String) {
        self.icon = icon
    }
}