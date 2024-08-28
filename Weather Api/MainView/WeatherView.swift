//
//  ContentView.swift
//  Weather Api
//
//  Created by Nicolas Rios on 8/27/24.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.temperatures.isEmpty {
                    Text("No temperatures available")
                        .font(.title)
                        .padding()
                } else {
                    List(viewModel.temperatures) { entry in
                        HStack {
                            Image(systemName: "sun.max.fill")
                                .foregroundColor(.yellow)
                                .padding(.trailing, 10)

                            Text("\(entry.temperature, specifier: "%.1f")°C")
                                .font(.headline)
                        }
                        .padding(.vertical, 5)
                    }
                    .listStyle(InsetGroupedListStyle())
                }

                Button(action: {
                    Task {
                        await viewModel.fetchWeather(zip: "92618")
                    }
                }) {
                    Text("Fetch Weather")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top)
            }
          
        }
    }
}

