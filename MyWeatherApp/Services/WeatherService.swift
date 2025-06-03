//
//  WeatherService.swift
//  MyWeatherApp
//
//  Created by Alexander Fedotov on 03.06.2025.
//

// Services/WeatherService.swift
import Foundation

final class WeatherService {
    private let apiKey = "c4dbad85c8fb4a1a8e6120723250306"

    func fetchForecast(for query: String, completion: @escaping (ForecastResponse?) -> Void) {
        let urlStr = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(query)&days=3&aqi=no&alerts=no"
        guard let url = URL(string: urlStr) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            let forecast = try? JSONDecoder().decode(ForecastResponse.self, from: data)
            DispatchQueue.main.async {
                completion(forecast)
            }
        }.resume()
    }
}

