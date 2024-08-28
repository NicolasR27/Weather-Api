//
//  WeatherViewModel.swift
//  Weather Api
//
//  Created by Nicolas Rios on 8/27/24.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var temperatures: [TemperatureEntry] = []

    func fetchWeather(zip: String) async {
        guard let temp = await fetchTemperature(for: zip) else {
            print("Failed to fetch temperature.")
            return
        }

        DispatchQueue.main.async {
            let entry = TemperatureEntry(temperature: temp)
            self.temperatures.append(entry)
        }
    }
}


