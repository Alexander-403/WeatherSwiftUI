//
//  WeatherService.swift
//  WeatherSwiftUI
//
//  Created by Alexander B on 25.02.2026.
//

// Services/WeatherService.swift
import Foundation
import CoreLocation

final class WeatherService {
    static let shared = WeatherService()
    
    private let baseURL = "https://api.open-meteo.com/v1/forecast"
    
    func fetchWeather(for location: CLLocationCoordinate2D) async throws -> WeatherResponse {
        var components = URLComponents(string: baseURL)!
        
        components.queryItems = [
            URLQueryItem(name: "latitude", value: "\(location.latitude)"),
            URLQueryItem(name: "longitude", value: "\(location.longitude)"),
            URLQueryItem(name: "current", value: "temperature_2m,relative_humidity_2m,apparent_temperature,weather_code,wind_speed_10m,wind_direction_10m"),
            URLQueryItem(name: "daily", value: "weather_code,temperature_2m_max,temperature_2m_min,sunrise,sunset"),
            URLQueryItem(name: "timezone", value: "auto"),
            URLQueryItem(name: "forecast_days", value: "7")
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        print("ЗАПРОС ПОГОДЫ: \(url.absoluteString)")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("СТАТУС-КОД ОТ API: \(httpResponse.statusCode)")
            
            if httpResponse.statusCode != 200 {
                let errorText = String(data: data, encoding: .utf8) ?? "[не текст]"
                print("ОШИБКА ОТ API: \(errorText)")
                throw URLError(.badServerResponse)
            }
        }
        
        let responseString = String(data: data, encoding: .utf8) ?? "[бинарные данные]"
        print("ПОЛУЧЕННЫЙ ОТВЕТ (первые 1000 символов):")
        print(responseString.prefix(1000))
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let decoded = try decoder.decode(WeatherResponse.self, from: data)
            print("Декодирование успешно!")
            return decoded
        } catch {
            print("ОШИБКА ДЕКОДИРОВАНИЯ: \(error.localizedDescription)")
            throw error
        }
    }
}
