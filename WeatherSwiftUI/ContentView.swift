
import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    @State private var showingCityPicker = false
    @State private var selectedCityName: String = "Выберите город"
    
    var body: some View {
        NavigationStack {
            mainContent
                .navigationTitle("Погода")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            showingCityPicker = true
                        } label: {
                            Image(systemName: "list.bullet")
                                .font(.title2)
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Обновить") {
                            if let coord = viewModel.selectedCoordinate {
                                viewModel.locationName = selectedCityName
                                viewModel.fetchWeather(for: coord)
                            }
                        }
                    }
                }
                .sheet(isPresented: $showingCityPicker) {
                    cityPickerSheet
                }
        }
    }
    
    private var mainContent: some View {
        ZStack {
            backgroundGradient
            
            VStack(spacing: 20) {
                Text(viewModel.locationName)
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 40)
                
                weatherContent
                
                if !viewModel.dailyForecast.isEmpty {
                    dailyForecastSection
                }
            }
            .padding()
        }
    }
    
    private var backgroundGradient: some View {
        LinearGradient(
            colors: [.blue.opacity(0.6), .cyan.opacity(0.4)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
    
    private var weatherContent: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(1.5)
                    .padding()
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            } else if let current = viewModel.currentWeather {
                currentWeatherSection(current: current)
            } else {
                Text("Выберите город в меню")
                    .foregroundColor(.white)
                    .font(.title2)
            }
        }
    }
    
    private func currentWeatherSection(current: CurrentWeather) -> some View {
        let (desc, icon) = WeatherCondition.description(for: current.weatherCode)
        
        return VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 100))
                .foregroundColor(.white)
                .symbolRenderingMode(.multicolor)
            
            Text("\(Int(current.temperature2m))°")
                .font(.system(size: 80, weight: .bold))
                .foregroundColor(.white)
            
            Text(desc)
                .font(.title2)
                .foregroundColor(.white.opacity(0.9))
            
            HStack(spacing: 40) {
                WeatherInfo(icon: "wind", value: "\(Int(current.windSpeed10m)) км/ч")
                WeatherInfo(icon: "humidity", value: "\(current.relativeHumidity2m)%")
                WeatherInfo(icon: "thermometer", value: "\(Int(current.apparentTemperature))°")
            }
            .foregroundColor(.white)
        }
    }
    
    private var dailyForecastSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(viewModel.dailyForecast) { day in
                    DailyForecastCard(day: day)
                }
            }
            .padding(.horizontal)
        }
        .padding(.top, 20)
    }
    
    private var cityPickerSheet: some View {
        NavigationStack {
            List {
                ForEach(availableCountries) { country in
                    Section(header: Text(country.name)) {
                        ForEach(country.cities) { city in
                            Button {
                                viewModel.selectedCoordinate = CLLocationCoordinate2D(
                                    latitude: city.latitude,
                                    longitude: city.longitude
                                )
                                viewModel.locationName = city.name
                                viewModel.fetchWeather(for: viewModel.selectedCoordinate!)
                                showingCityPicker = false
                            } label: {
                                Text(city.name)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Выберите город")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Закрыть") { showingCityPicker = false }
                }
            }
        }
    }
}

// MARK: - Вспомогательные View

struct WeatherInfo: View {
    let icon: String
    let value: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title2)
            Text(value)
                .font(.subheadline)
        }
    }
}

struct DailyForecastCard: View {
    let day: WeatherViewModel.DailyItem
    
    var body: some View {
        VStack {
            Text(String(day.dayName.prefix(6)))
                .font(.subheadline)
            
            let (_, icon) = WeatherCondition.description(for: day.code)
            
            Image(systemName: icon)
                .font(.title)
                .symbolRenderingMode(.multicolor)
                .padding(.vertical, 4)
            
            Text("\(Int(day.maxTemp))° / \(Int(day.minTemp))°")
                .font(.subheadline.bold())
        }
        .frame(width: 90, height: 140)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
