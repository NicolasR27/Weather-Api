import Foundation

// Define a global dictionary to store weather history
var weatherHistory: [String: Double] = [:]

// Function to get weather data for a specific date and zip code
func getTemperature(for date: Date, zip: String) async -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let dateString = dateFormatter.string(from: date)
    let key = "\(dateString)-\(zip)"

    // Check if the temperature for the given date and zip is already stored
    if let temperature = weatherHistory[key] {
        return "The temperature for \(zip) on \(dateString) was \(temperature)°C."
    }

    // Check if the requested date is today
    if Calendar.current.isDateInToday(date) {
        // Fetch the temperature for today using OpenWeatherMap API
        let temperature = await fetchTemperature(for: zip)

        // If temperature is successfully fetched, store it in the history
        if let temp = temperature {
            weatherHistory[key] = temp
            return "The temperature for \(zip) on \(dateString) is \(temp)°C."
        } else {
            return "Failed to retrieve the temperature for \(zip) on \(dateString)."
        }
    } else {
        // If the date is not today and the data isn't available, return a message
        return "No data available for \(zip) on \(dateString)."
    }
}

// Function to fetch today's temperature from the OpenWeatherMap API
func fetchTemperature(for zip: String) async -> Double? {
    let apiKey = "d9d6b642ca88454a3396830792d4b9a7"
    let urlString = "http://api.openweathermap.org/data/2.5/weather?zip=\(zip)&appid=\(apiKey)&units=metric"

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

// Model for decoding JSON response from OpenWeatherMap API
struct WeatherResponse: Codable {
    struct Main: Codable {
        let temp: Double
    }
    let main: Main
}

// Example usage
Task {
    let result = await getTemperature(for: Date(), zip: "92618")
    print(result)
}
