//
//  WeatherView.swift
//  finalTourGuideSQL
//
//  Created by KENK on 2024/3/26.
//
import SwiftUI
import CoreLocation

struct WeatherView: View {
    @StateObject var weatherManager = WeatherManager()
    @StateObject private var locationManager = LocationManager()
    @State private var searchText = ""

    var body: some View {
        ZStack {
            // Background image setup
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    // 添加定位按钮
                    Button(action: {
                        locationManager.requestLocation() // request4Location
                    }) {
                        Image(systemName: "location.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    .padding(.leading, 10)

                    TextField("搜索城市...", text: $searchText)
                        .textInputAutocapitalization(TextInputAutocapitalization?.none)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.white)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.black.opacity(0.5)))
                        .frame(height: 40)

                    Button(action: {
                        // search weather
                        weatherManager.fetchWeather(cityName: searchText.isEmpty ? "Urumqi" : searchText)
                        searchText = ""
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(.trailing, 10)
                    }
                    .background(Color.clear)
                    .frame(width: 44, height: 44)
                }
                .frame(width: 350)
                // Weather inforDisplay
                if let weather = weatherManager.weather {
                    Text("\(weather.cityName)")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    Text("\(weather.temperatureString)°C")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    Image(systemName: weather.conditionName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.white)
                }
            }
            .padding()
        }
        .onAppear {
            weatherManager.fetchWeather(cityName: "Urumqi") // defaultCity
        }
        .onChange(of: locationManager.lastLocation) { newLocation in
            // update weather when location changes
            if let location = newLocation {
                weatherManager.fetchWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            }
        }
    }
}

#Preview {
    WeatherView()
}
