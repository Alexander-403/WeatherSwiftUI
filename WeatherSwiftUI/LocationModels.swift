//
//  LocationModels.swift
//  WeatherSwiftUI
//
//  Created by Alexander B on 26.02.2026.
//

import Foundation

// Модель страны
struct Country: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let code: String   
    let cities: [City]
}

// Модель города
struct City: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
}

// Список стран и городов (основной источник данных)
let availableCountries: [Country] = [
    // Россия
    Country(name: "Россия", code: "RU", cities: [
        City(name: "Санкт-Петербург", latitude: 59.9343, longitude: 30.3351),
        City(name: "Москва", latitude: 55.7558, longitude: 37.6173),
        City(name: "Новосибирск", latitude: 55.0084, longitude: 82.9357),
        City(name: "Екатеринбург", latitude: 56.8389, longitude: 60.6057),
        City(name: "Казань", latitude: 55.8304, longitude: 49.0661),
        City(name: "Нижний Новгород", latitude: 56.2965, longitude: 43.9361),
        City(name: "Краснодар", latitude: 45.0355, longitude: 38.9748),
        City(name: "Сочи", latitude: 43.5855, longitude: 39.7231),
        City(name: "Владивосток", latitude: 43.1155, longitude: 131.8855),
        City(name: "Калининград", latitude: 54.7104, longitude: 20.4522)
    ]),
    
    // Украина
    Country(name: "Украина", code: "UA", cities: [
        City(name: "Киев", latitude: 50.4501, longitude: 30.5234),
        City(name: "Харьков", latitude: 49.9935, longitude: 36.2304),
        City(name: "Одесса", latitude: 46.4825, longitude: 30.7233),
        City(name: "Львов", latitude: 49.8397, longitude: 24.0297),
        City(name: "Днепр", latitude: 48.4647, longitude: 35.0462)
    ]),
    
    // Беларусь
    Country(name: "Беларусь", code: "BY", cities: [
        City(name: "Минск", latitude: 53.9000, longitude: 27.5667),
        City(name: "Гомель", latitude: 52.4345, longitude: 30.7866),
        City(name: "Брест", latitude: 52.0975, longitude: 23.6878)
    ]),
    
    // США
    Country(name: "США", code: "US", cities: [
        City(name: "Нью-Йорк", latitude: 40.7128, longitude: -74.0060),
        City(name: "Лос-Анджелес", latitude: 34.0522, longitude: -118.2437),
        City(name: "Чикаго", latitude: 41.8781, longitude: -87.6298),
        City(name: "Сан-Франциско", latitude: 37.7749, longitude: -122.4194),
        City(name: "Майами", latitude: 25.7617, longitude: -80.1918),
        City(name: "Лас-Вегас", latitude: 36.1699, longitude: -115.1398),
        City(name: "Сиэтл", latitude: 47.6062, longitude: -122.3321),
        City(name: "Гонолулу", latitude: 21.3069, longitude: -157.8583)
    ]),
    
    // Европа
    Country(name: "Германия", code: "DE", cities: [
        City(name: "Берлин", latitude: 52.5200, longitude: 13.4050),
        City(name: "Мюнхен", latitude: 48.1351, longitude: 11.5820),
        City(name: "Гамбург", latitude: 53.5511, longitude: 9.9937)
    ]),
    
    Country(name: "Франция", code: "FR", cities: [
        City(name: "Париж", latitude: 48.8566, longitude: 2.3522),
        City(name: "Лион", latitude: 45.7640, longitude: 4.8357),
        City(name: "Марсель", latitude: 43.2965, longitude: 5.3698)
    ]),
    
    Country(name: "Италия", code: "IT", cities: [
        City(name: "Рим", latitude: 41.9028, longitude: 12.4964),
        City(name: "Милан", latitude: 45.4642, longitude: 9.1900),
        City(name: "Венеция", latitude: 45.4408, longitude: 12.3155)
    ]),
    
    Country(name: "Испания", code: "ES", cities: [
        City(name: "Мадрид", latitude: 40.4168, longitude: -3.7038),
        City(name: "Барселона", latitude: 41.3851, longitude: 2.1734),
        City(name: "Валенсия", latitude: 39.4699, longitude: -0.3763)
    ]),
    
    Country(name: "Великобритания", code: "GB", cities: [
        City(name: "Лондон", latitude: 51.5074, longitude: -0.1278),
        City(name: "Эдинбург", latitude: 55.9533, longitude: -3.1883),
        City(name: "Манчестер", latitude: 53.4808, longitude: -2.2426)
    ]),
    
    Country(name: "Турция", code: "TR", cities: [
        City(name: "Стамбул", latitude: 41.0082, longitude: 28.9784),
        City(name: "Анкара", latitude: 39.9334, longitude: 32.8597),
        City(name: "Анталья", latitude: 36.8969, longitude: 30.7133)
    ]),
    
    Country(name: "Япония", code: "JP", cities: [
        City(name: "Токио", latitude: 35.6762, longitude: 139.6503),
        City(name: "Осака", latitude: 34.6937, longitude: 135.5023),
        City(name: "Киото", latitude: 35.0116, longitude: 135.7681)
    ])
    
    // Добавляй новые страны по желанию в таком же формате
]
//extension CLLocationCoordinate2D: Equatable {
//    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
//        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
//    }
//}
