//
//  ContentView.swift
//  MyWeatherApp
//
//  Created by Alexander Fedotov on 03.06.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var forecast: ForecastResponse?
    @State private var city = "Moscow"
    @State private var isLoading = false

    let weatherService = WeatherService()

    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter city", text: $city)
                .textFieldStyle(.roundedBorder)
                .padding()

            Button("Get Weather") {
                fetchWeather()
            }
            .buttonStyle(.borderedProminent)

            if let forecast = forecast {
                VStack(spacing: 8) {
                    Text("\(forecast.location.name), \(forecast.location.country)")
                        .font(.title2)
                    Text("\(forecast.current.temp_c, specifier: "%.1f")°C")
                        .font(.largeTitle)
                    Text(forecast.current.condition.text)
                        .italic()
                    AsyncImage(url: URL(string: "https:\(forecast.current.condition.icon)")) { image in
                        image.resizable().frame(width: 50, height: 50)
                    } placeholder: {
                        ProgressView()
                    }

                    Divider()

                    Text("3-Day Forecast")
                        .font(.headline)
                    ForEach(forecast.forecast.forecastday) { day in
                        HStack {
                            Text(day.date)
                            Spacer()
                            Text("\(day.day.avgtemp_c, specifier: "%.1f")°C")
                            AsyncImage(url: URL(string: "https:\(day.day.condition.icon)")) { image in
                                image.resizable().frame(width: 30, height: 30)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            } else if isLoading {
                ProgressView("Loading...")
            } else {
                Text("Enter a city and tap the button")
                    .foregroundStyle(.gray)
            }
        }
        .padding()
    }

    func fetchWeather() {
        isLoading = true
        weatherService.fetchForecast(for: city) { result in
            isLoading = false
            self.forecast = result
        }
    }
}
#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
