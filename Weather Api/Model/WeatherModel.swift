//
//  WeatherModel.swift
//  Weather Api
//
//  Created by Nicolas Rios on 8/27/24.
//

import SwiftUI

struct WeatherResponse: Codable {
    struct Main: Codable {
        let temp: Double
    }
    let main: Main
}



//// Example usage
//Task {
//    let result = await getTemperature(for: Date(), zip: "92618")
//    print(result)
//}
