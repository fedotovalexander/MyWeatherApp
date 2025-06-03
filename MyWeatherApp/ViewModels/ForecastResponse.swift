//
//  WeatherViewModel.swift
//  MyWeatherApp
//
//  Created by Alexander Fedotov on 03.06.2025.
//

// ViewModels/WeatherViewModel.swift
// WeatherModel.swift

import Foundation

struct ForecastResponse: Decodable {
    let location: Location
    let current: Current
    let forecast: Forecast
}

struct Forecast: Decodable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Decodable, Identifiable {
    let date: String
    let day: Day

    var id: String { date }
}

struct Day: Decodable {
    let avgtemp_c: Double
    let condition: Condition
}

struct Location: Decodable {
    let name: String
    let country: String
}

struct Current: Decodable {
    let temp_c: Double
    let condition: Condition
}

struct Condition: Decodable {
    let text: String
    let icon: String
}
