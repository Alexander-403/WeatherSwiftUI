//
//  WeatherViewModel.swift
//  WeatherSwiftUI
//
//  Created by Alexander B on 25.02.2026.
//

import Foundation
import CoreLocation
import MapKit
import Combine
struct DailyItem: Identifiable {
    let id = UUID()
    let date: String
    let code: Int
    let maxTemp: Double
    let minTemp: Double
    
    var dayName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let dateObj = formatter.date(from: date) else { return date }
        
        formatter.dateFormat = "E, d MMM"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: dateObj)
    }
}
@MainActor
final class WeatherViewModel: ObservableObject {
    @Published var currentWeather: CurrentWeather?
    @Published var dailyForecast: [DailyItem] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var locationName: String = "Определяем местоположение..."
    @Published var selectedCoordinate: CLLocationCoordinate2D? = nil
    
    private let weatherService = WeatherService.shared
    private let locationManager = CLLocationManager()
    
    init() {
        // requestLocation()  // только ручной выбор
        locationName = "Выберите город"
    }

    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        
        if let location = locationManager.location {
            fetchWeather(for: location.coordinate)
            Task {
                await reverseGeocode(location: location)
            }
        } else {
            locationManager.startUpdatingLocation()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
                guard let self else { return }
                if let location = self.locationManager.location {
                    self.fetchWeather(for: location.coordinate)
                    Task {
                        await self.reverseGeocode(location: location)
                    }
                } else {
                    self.errorMessage = "Не удалось определить местоположение"
                }
                self.locationManager.stopUpdatingLocation()
            }
        }
    }
    
    func fetchWeather(for coordinate: CLLocationCoordinate2D) {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let response = try await weatherService.fetchWeather(for: coordinate)
                
                self.currentWeather = response.current
                
                let daily = response.daily
                let count = min(
                    daily.time.count,
                    daily.weatherCode.count,
                    daily.temperature2mMax.count,
                    daily.temperature2mMin.count
                )
                
                self.dailyForecast = (0..<count).map { index in
                    DailyItem(
                        date: daily.time[index],
                        code: daily.weatherCode[index],
                        maxTemp: daily.temperature2mMax[index],
                        minTemp: daily.temperature2mMin[index]
                    )
                }
            } catch {
                errorMessage = "Не удалось загрузить погоду: \(error.localizedDescription)"
            }
            
            await MainActor.run {
                isLoading = false
            }
        }
    }
    
    private func reverseGeocode(location: CLLocation) async {
        guard let request = MKReverseGeocodingRequest(location: location) else {
            await MainActor.run {
                self.locationName = "Невозможно создать запрос геокодирования"
            }
            return
        }
        
        do {
            let mapItems = try await request.mapItems
            
            if let mapItem = mapItems.first {
                let city = mapItem.placemark.locality ?? ""
                let area = mapItem.placemark.administrativeArea ?? ""
                let country = mapItem.placemark.country ?? ""
                
                let nameParts = [city, area, country].filter { !$0.isEmpty }
                let displayName = nameParts.joined(separator: ", ")
                
                await MainActor.run {
                    self.locationName = displayName.isEmpty ? "Неизвестно" : displayName
                }
            } else {
                await MainActor.run {
                    self.locationName = "Местоположение не определено"
                }
            }
        } catch {
            print("Reverse geocoding failed: \(error.localizedDescription)")
            await MainActor.run {
                self.locationName = "Не удалось определить город"
            }
        }
    }
    
    struct DailyItem: Identifiable {
        let id = UUID()
        let date: String
        let code: Int
        let maxTemp: Double
        let minTemp: Double
        
        var dayName: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            guard let dateObj = formatter.date(from: date) else { return date }
            
            formatter.dateFormat = "E, d MMM"
            formatter.locale = Locale(identifier: "ru_RU")
            return formatter.string(from: dateObj)
        }
    }
}
