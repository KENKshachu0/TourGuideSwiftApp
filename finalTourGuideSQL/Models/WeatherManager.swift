//
//  WeatherManager.swift
//  finalTourGuideSQL
//
//  Created by KENK on 2024/3/27.
//    "https://api.openweathermap.org/data/2.5/weather?lang=zh_cn&appid=\(key.weatherKey)&units=metric"

import Foundation
import CoreLocation

class WeatherManager: ObservableObject {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?lang=zh_cn&appid=\(key.weatherKey)&units=metric"
    
    @Published var weather: WeatherModel?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    private func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if let error = error {
                    print("Request error: ", error)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        DispatchQueue.main.async {
                            self.weather = weather
                        }
                    }
                }
            }
            
            task.resume()
        }
    }
    
    private func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let country = decodedData.sys.country
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, countryName: country)
            return weather
        } catch {
            print("Error parsing JSON: ", error)
            return nil
        }
    }
}
