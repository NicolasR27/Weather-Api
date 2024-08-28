//
//   NetworkCall.swift
//  Weather Api
//
//  Created by Nicolas Rios on 8/27/24.
//

import Foundation

func fetchTemperature(for zip: String) async -> Double? {
    let apiKey = "d9d6b642ca88454a3396830792d4b9a7"
    let urlString = "https://api.openweathermap.org/data/2.5/weather?zip=\(zip)&appid=\(apiKey)&units=metric"  // Changed to https

    guard let url = URL(string: urlString) else {
        print("Invalid URL.")
        return nil
    }

    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        let weatherData = try JSONDecoder().decode(WeatherResponse.self, from: data)
        return weatherData.main.temp
    } catch {
        print("Error fetching data: \(error.localizedDescription)")
        return nil
    }

}
