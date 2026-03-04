//
//  WeatherModels.swift
//  WeatherSwiftUI
//
//  Created by Alexander B on 25.02.2026.
//

import Foundation

// Основная структура для текущей погоды + прогноз
struct WeatherResponse: Codable {
    let current: CurrentWeather
    let daily: DailyWeather
    let hourly: HourlyWeather?
    
    enum CodingKeys: String, CodingKey {
        case current
        case daily
        case hourly
    }
}

struct CurrentWeather: Codable {
    let time: String
    let temperature2m: Double
    let relativeHumidity2m: Int
    let apparentTemperature: Double
    let weatherCode: Int
    let windSpeed10m: Double
    let windDirection10m: Int?
    
    enum CodingKeys: String, CodingKey {
        case time
        case temperature2m = "temperature_2m"
        case relativeHumidity2m = "relative_humidity_2m"
        case apparentTemperature = "apparent_temperature"
        case weatherCode = "weather_code"
        case windSpeed10m = "wind_speed_10m"
        case windDirection10m = "wind_direction_10m"
    }
}

struct DailyWeather: Codable {
    let time: [String]
    let weatherCode: [Int]
    let temperature2mMax: [Double]
    let temperature2mMin: [Double]
    let sunrise: [String]?
    let sunset: [String]?
    
    enum CodingKeys: String, CodingKey {
        case time
        case weatherCode = "weather_code"
        case temperature2mMax = "temperature_2m_max"
        case temperature2mMin = "temperature_2m_min"
        case sunrise
        case sunset
    }
}


struct HourlyWeather: Codable {
    let time: [String]
    let temperature2m: [Double]
    let weatherCode: [Int]
    
    enum CodingKeys: String, CodingKey {
        case time
        case temperature2m = "temperature_2m"
        case weatherCode = "weather_code"
    }
}

//struct WeatherCondition {
//    static func description(for code: Int) -> (text: String, icon: String) {
//        switch code {
//        case 0: return ("Ясно", "sun.max.fill")
//        case 1, 2, 3: return ("Облачно", "cloud.sun.fill")
//        case 45, 48: return ("Туман", "cloud.fog.fill")
//        case 51...57, 61...67, 80...82: return ("Дождь", "cloud.rain.fill")
//        case 71...77, 85, 86: return ("Снег", "snowflake")
//        case 95...99: return ("Гроза", "cloud.bolt.rain.fill")
//        default: return ("Неизвестно", "questionmark.circle")
//        }
//    }
struct WeatherCondition {
    static func description(for code: Int) -> (text: String, icon: String) {
        switch code {
        // Ясно / малооблачно
        case 0: return ("Ясно", "sun.max.fill")
        case 1: return ("В основном ясно", "sun.min.fill")
        case 2: return ("Переменная облачность", "cloud.sun.fill")
        case 3: return ("Пасмурно", "cloud.fill")  // ← вот твой код 3

        // Туман
        case 45: return ("Туман", "cloud.fog.fill")
        case 48: return ("Изморозь", "cloud.fog.fill")

        // Мелкий дождь / морось
        case 51, 53, 55: return ("Морось", "cloud.drizzle.fill")
        case 56, 57: return ("Морозная морось", "cloud.drizzle.fill")

        // Дождь
        case 61, 63, 65: return ("Дождь", "cloud.rain.fill")
        case 66, 67: return ("Ледяной дождь", "cloud.sleet.fill")
        case 80, 81, 82: return ("Ливень", "cloud.heavyrain.fill")

        // Снег
        case 71, 73, 75: return ("Снег", "snowflake")
        case 77: return ("Снежные зёрна", "snowflake")
        case 85, 86: return ("Снег с дождём", "cloud.snow.fill")

        // Гроза
        case 95: return ("Гроза", "cloud.bolt.rain.fill")
        case 96, 99: return ("Гроза с градом", "cloud.bolt.rain.fill")

        default: return ("Неизвестно (\(code))", "questionmark.circle")
        }
    }
}
