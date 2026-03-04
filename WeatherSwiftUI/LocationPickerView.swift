//
//  LocationPickerView.swift
//  WeatherSwiftUI
//
//  Created by Alexander B on 26.02.2026.
//

import SwiftUI
import CoreLocation

struct LocationPickerView: View {
    @Binding var selectedCoordinate: CLLocationCoordinate2D?
    @Binding var selectedCityName: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(availableCountries) { country in
                    Section(header: Text(country.name).font(.headline)) {
                        ForEach(country.cities) { city in
                            Button {
                                selectedCoordinate = CLLocationCoordinate2D(
                                    latitude: city.latitude,
                                    longitude: city.longitude
                                )
                                selectedCityName = city.name
                                dismiss()
                            } label: {
                                Text(city.name)
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Выберите город")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Закрыть") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    LocationPickerView(
        selectedCoordinate: .constant(nil),
        selectedCityName: .constant("Выберите город")
    )
}
