//
//  WeatherModel.swift
//  finalTourGuideSQL
//
//  Created by KENK on 2024/3/27.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let countryName: String
    //let cnCountryName: String    cnCountryName的对比好像不太行
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let sys: Sys
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}

struct Sys: Codable {
    let country: String
}
