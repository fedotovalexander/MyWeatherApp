//
//  Item.swift
//  MyWeatherApp
//
//  Created by Alexander Fedotov on 03.06.2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
